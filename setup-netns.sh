#!/bin/sh

. ./config.sh

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
wg genkey > host-privkey
wg genkey > ns-privkey
ip link add ${NIC}-wg type wireguard
wg set ${NIC}-wg listen-port ${HOST_PORT} private-key host-privkey
ip addr add ${HOST_WG_IP}/32 dev ${NIC}-wg peer ${NS_WG_IP}
wg set ${NIC}-wg peer $(wg pubkey < ns-privkey) allowed-ips ${NS_WG_IP}/32 endpoint ${NS_VETH_IP}:${NS_PORT}
ip link set ${NIC}-wg up

# Setup WG for netns
ip netns exec ${NETNS} ip link add ${NIC}-wg type wireguard
ip netns exec ${NETNS} wg set ${NIC}-wg listen-port ${NS_PORT} private-key $PWD/ns-privkey
ip netns exec ${NETNS} ip addr add ${NS_WG_IP}/32 dev ${NIC}-wg peer ${HOST_WG_IP}
ip netns exec ${NETNS} wg set ${NIC}-wg peer $(wg pubkey < $PWD/host-privkey) allowed-ips ${HOST_WG_IP}/32 endpoint ${HOST_VETH_IP}:${HOST_PORT}
ip netns exec ${NETNS} ip link set ${NIC}-wg up
rm host-privkey
rm ns-privkey
