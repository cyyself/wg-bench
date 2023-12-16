#!/bin/sh

. ./config.sh

# Delete netns
ip netns del ${NETNS}

# Delete veth
ip link del ${NIC}

# Delete WG
ip link del ${NIC}-wg