# WireGuard Benchmark

Test WireGuard performance using netns and iperf3.

## How to use

```shell
sudo ./setup-netns.sh
sudo ./benchmark.sh
sudo ./clean-up.sh
```

## Note for OpenWRT

In OpenWRT, you need to install `ip-full` and `kmod-veth` packages.

## About Result

This program only benchmarks your CPU and Kernel network stack, the end-to-end performance will also be affected by your NIC, NIC-driver etc.