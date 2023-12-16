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


## Test Results

| Device / CPU                   | OS / Kernel                | TCP Speed      |
| ------------------------------ | -------------------------- | -------------- |
| CMCC RAX3000M / MT7981         | OpenWRT 23.05.2 / 5.15.137 | 369 Mbits/sec  |
| 360 T7 / MT7981                | OpenWRT 23.05.0 / 5.15.134 | 369 Mbits/sec  |
| Redmi AX6S / MT7622            | OpenWRT 23.05.2 / 5.15.137 | 391 Mbits/sec  |
| Sipeed Lichee Pi 4A / TH1520   | RevyOS / 6.6.4             | 451 Mbits/sec  |
| Phicomm N1 / S905D             | ophub-openwrt / 6.1.66     | 537 Mbits/sec  |
| TP-Link XDR 6088 / MT7986      | OpenWRT 23.05.0 / 5.15.134 | 818 Mbits/sec  |
| Intel Celeron(R) J4125         | Linux pve / 6.2.16         | 2.12 Gbits/sec |
| Intel Pentium(R) Silver N6005  | iStoreOS / 5.10.176        | 3.85 Gbits/sec |
| Intel Core i9 13900K           | Debian trixie / 6.5.13     | 7.53 Gbits/sec |

If you have more results to show, PR is welcomed.
