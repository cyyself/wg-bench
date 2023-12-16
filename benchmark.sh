#!/bin/sh

. ./config.sh

# Please run setup-netns.sh first

# Run iperf3
ip netns exec ${NETNS} iperf3 -s -D -I $PWD/iperf3.pid
iperf3 -c ${NS_WG_IP} $@
ip netns exec ${NETNS} kill $(cat ./iperf3.pid)