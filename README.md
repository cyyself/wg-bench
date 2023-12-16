# WireGuard Benchmark

Test WireGuard performance using netns and iperf3.

## How to use

In most distros, `wireguard-tools` and `iperf3` are the only required packages.

In OpenWRT, packages `ip-full` and `kmod-veth` are also required.

```shell
sudo ./setup-netns.sh
sudo ./benchmark.sh
sudo ./clean-up.sh
```

## Test Results

| Device / CPU                   | OS / Kernel / iperf Param  | Speed          |
| ------------------------------ | -------------------------- | -------------- |
| CMCC RAX3000M / MT7981         | OpenWRT 23.05.2 / 5.15.137 | 369 Mbits/sec  |
| 360 T7 / MT7981                | OpenWRT 23.05.0 / 5.15.134 | 369 Mbits/sec  |
| Redmi AX6S / MT7622            | OpenWRT 23.05.2 / 5.15.137 | 391 Mbits/sec  |
| Sipeed Lichee Pi 4A / TH1520   | RevyOS / 6.6.4             | 451 Mbits/sec  |
| Phicomm N1 / S905D             | ophub-openwrt / 6.1.66     | 537 Mbits/sec  |
| TP-Link XDR 6088 / MT7986      | OpenWRT 23.05.0 / 5.15.134 | 818 Mbits/sec  |
| Mac Mini (2020) / Apple M1     | AsahiLinux / 6.5.0         | 1.60 Gbits/sec |
| Mac Mini (2020) / Apple M1     | AsahiLinux / 6.5.0 / -R    | 3.62 Gbits/sec |
| Phytium D2000x8 (2.3GHz)       | Debian bookworm / 6.1.66   | 2.05 Gbits/sec |
| Intel Celeron(R) J4125         | Linux pve / 6.2.16         | 2.12 Gbits/sec |
| Intel Pentium(R) Silver N6005  | iStoreOS / 5.10.176        | 3.85 Gbits/sec |
| AMD Ryzen 5 PRO 5650GE         | Linux pve / 6.2.16         | 5.29 Gbits/sec |
| Intel Core i9 13900K           | Debian trixie / 6.5.13     | 7.53 Gbits/sec |

If you have more results to show, PR is welcomed.

We recommend also testing with `-R` by `sudo ./benchmark.sh -R` before submitting the result.

If you see quite a difference in speed which might happen on BIG.little CPU architecture (such as Apple M1), please note this in your commit.

## About Result

This program only benchmarks your CPU and Kernel network stack, the end-to-end performance will also be affected by your NIC, NIC driver, etc.
