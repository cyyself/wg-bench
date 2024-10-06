#!/bin/sh

#set -x

NAME=$(grep NAME /etc/os-release | head -n 1 | awk -F '"' '{print $2}')

NETNS="wg-bench"
NIC="wg-bench"
HOST_VETH_IP="11.0.0.1"
NS_VETH_IP="11.0.0.2"
HOST_WG_IP="169.254.200.1"
NS_WG_IP="169.254.200.2"
HOST_PORT="11001"
NS_PORT="11002"

if [ "$NAME" != "OpenWrt" ]; then
    echo "This is not OpenWrt. Exit"
    exit 1
fi

if [ $(ls /tmp/opkg-lists/ | wc -l) -eq "0" ]; then
    opkg update
fi

printf "\033[32;1m\nPackages:\033[0m\n"

if opkg list-installed | grep -q wireguard-tools; then
    echo "WireGuard already installed"
else
    echo "Installed wg..."
    opkg install wireguard-tools
fi

if opkg list-installed | grep -q iperf3; then
    echo "Iperf3 already installed"
else
    echo "Installed iperf3..."
    opkg install iperf3
fi

if opkg list-installed | grep -q ip-full; then
    echo "ip-full already installed"
else
    echo "Installed ip-full..."
    opkg install ip-full
fi

if opkg list-installed | grep -q kmod-veth; then
    echo "kmod-veth already installed"
else
    echo "Installed kmod-veth..."
    opkg install kmod-veth
fi

if opkg list-installed | grep -q psmisc; then
    echo "psmisc already installed"
else
    echo "Installed psmisc..."
    opkg install psmisc
fi

printf "\033[32;1m\nRouter details:\033[0m\n"
ubus call system board

setup() {
    # Create netns
    ip netns add ${NETNS}

    # Create veth
    ip link add ${NIC} type veth peer name ${NIC}-ns
    ip link set ${NIC}-ns netns ${NETNS}
    ip addr add ${HOST_VETH_IP}/30 dev ${NIC}
    ip netns exec ${NETNS} ip addr add ${NS_VETH_IP}/30 dev ${NIC}-ns
    ip link set ${NIC} up
    ip netns exec ${NETNS} ip link set ${NIC}-ns up

    # Setup WG for host
    wg genkey > host-privkey 2> /dev/null
    wg genkey > ns-privkey 2> /dev/null
    ip link add ${NIC}-wg type wireguard
    wg set ${NIC}-wg listen-port ${HOST_PORT} private-key host-privkey
    ip addr add ${HOST_WG_IP}/32 dev ${NIC}-wg peer ${NS_WG_IP}
    wg set ${NIC}-wg peer $(wg pubkey < ns-privkey) allowed-ips ${NS_WG_IP}/32 endpoint ${NS_VETH_IP}:${NS_PORT}
    ip link set ${NIC}-wg up

    # Set up WG for netns
    ip netns exec ${NETNS} ip link add ${NIC}-wg type wireguard
    ip netns exec ${NETNS} wg set ${NIC}-wg listen-port ${NS_PORT} private-key $PWD/ns-privkey
    ip netns exec ${NETNS} ip addr add ${NS_WG_IP}/32 dev ${NIC}-wg peer ${HOST_WG_IP}
    ip netns exec ${NETNS} wg set ${NIC}-wg peer $(wg pubkey < $PWD/host-privkey) allowed-ips ${HOST_WG_IP}/32 endpoint ${HOST_VETH_IP}:${HOST_PORT}
    ip netns exec ${NETNS} ip link set ${NIC}-wg up
    rm host-privkey
    rm ns-privkey
}


bench() {
    ip netns exec ${NETNS} iperf3 -s -D -p 4242
    sleep 2
    iperf3 -c ${NS_WG_IP} $@ -p 4242
    ip netns exec ${NETNS} fuser -k 4242/tcp
}

clean() {
    # Delete netns
    ip netns del ${NETNS}

    # Delete veth
    ip link del ${NIC}

    # Delete WG
    ip link del ${NIC}-wg
}

setup
bench
clean