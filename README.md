# WireGuard Benchmark

Test WireGuard performance using netns and iperf3.

## How to use

```shell
./setup-netns.sh
./benchmark.sh
./clean-up.sh
```

## Note for OpenWRT

In OpenWRT, you need to install `ip-full` package to manage netns.

## About Result

This program only benchmarks your CPU and Kernel network stack, the end-to-end performance will also be affected by your NIC, NIC-driver etc.