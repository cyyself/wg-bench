#!/bin/sh

#set -x

[ -s /etc/os-release ] && . /etc/os-release

NETNS="wg-bench"
NIC="wg-bench"
HOST_VETH_IP="11.0.0.1"
NS_VETH_IP="11.0.0.2"
HOST_WG_IP="169.254.200.1"
NS_WG_IP="169.254.200.2"
HOST_PORT="11001"
NS_PORT="11002"

DEVICE=$(cat /tmp/sysinfo/model 2>/dev/null || echo "Unknown Device")
VERSION=$(grep OPENWRT_RELEASE /etc/os-release | cut -d'"' -f2 | cut -d' ' -f1,2)
KERNEL_VERSION=$(uname -r)

if [ "$ID_LIKE" != "lede openwrt" ]; then
    echo "This is not OpenWrt. Exit"
    exit 1
fi

if command -v opkg >/dev/null 2>&1; then
    PKG_MANAGER="opkg"
    INSTALL_CMD="opkg install"
    LIST_INSTALLED_CMD="opkg list-installed"
elif command -v apk >/dev/null 2>&1; then
    PKG_MANAGER="apk"
    INSTALL_CMD="apk add"
    LIST_INSTALLED_CMD="apk list -I"
fi

printf "\033[32;1m\nPackages:\033[0m\n"
PACKAGES="wireguard-tools iperf3 ip-full kmod-veth psmisc"

UPDATE_NEEDED=false
PACKAGES_TO_INSTALL=""

for package in $PACKAGES; do
    if $LIST_INSTALLED_CMD | grep -q "$package"; then
        echo "$package already installed"
    else
        echo "$package needs to be installed"
        PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $package"
        UPDATE_NEEDED=true
    fi
done

if [ "$UPDATE_NEEDED" = true ]; then
    if [ "$PKG_MANAGER" = "opkg" ]; then
        echo "Updating package lists..."
        opkg update
    fi
    
    echo "Installing packages: $PACKAGES_TO_INSTALL"
    for package in $PACKAGES_TO_INSTALL; do
        $INSTALL_CMD "$package"
    done
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
    iperf3 -c ${NS_WG_IP} $@ -p 4242 | tee /tmp/iperf3_output
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

table() {
    if [ -f /tmp/iperf3_output ]; then
        speed=$(grep "sender" /tmp/iperf3_output | tail -1 | awk '{for(i=1;i<=NF;i++) if($i ~ /[MGK]bits\/sec/) print $(i-1) " " $i}')
        
        if [ -z "$speed" ]; then
            speed="N/A"
        fi
        
        rm -f /tmp/iperf3_output
    else
        speed="N/A"
    fi

    echo
    echo "Markdown Table Row:"
    printf "| %-32s | %-32s | %-14s | %s |\n" \
        "$DEVICE / ENTER CPU MODEL" \
        "$VERSION / $KERNEL_VERSION" \
        "$speed" \
        ""
}

setup
bench
clean
table