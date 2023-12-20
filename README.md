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

\* refers to this device having quite a difference in speed with different configurations.

| Device / CPU                     | OS / Kernel / iperf Param        | Speed          | Note |
| -------------------------------- | -------------------------------- | -------------- | - |
| Toshiba Satellite 480CDT / Pentium MMX 233MHz | Alpine Linux 3.18 / 6.2.0-rc7 | 3.2 Mbits/sec   | |
| D-Team Newifi D2 / MT7621        | OpenWrt 23.05.2 / 5.15.137       | 93 Mbits/sec   | |
| CMCC RAX3000M / MT7981           | OpenWRT 23.05.2 / 5.15.137       | 369 Mbits/sec  | |
| 360 T7 / MT7981                  | OpenWRT 23.05.0 / 5.15.134       | 369 Mbits/sec  | |
| Redmi AX6S / MT7622              | OpenWRT 23.05.2 / 5.15.137       | 391 Mbits/sec  | |
| Raspberry Pi 4 / BCM2711*        | Raspberry Pi OS / 6.1.63         | 394 Mbits/sec  | |
| StarFive VisionFive 2 / JH7110   | Debian trixie / 5.15.0           | 402 Mbits/sec  | |
| Milk-V Pioneer / SG2042          | RevyOS / 6.1.61                  | 440 Mbits/sec  | |
| Sipeed Lichee Pi 4A / TH1520     | RevyOS / 6.6.4                   | 451 Mbits/sec  | |
| Phicomm N1 / S905D               | ophub-openwrt / 6.1.66           | 537 Mbits/sec  | |
| Intel Celeron(R) J1800           | Ubuntu 22.04.3 / 5.15.0          | 551 Mbits/sec  | |
| Raspberry Pi 4 / BCM2711*        | archlinux / 6.1.61(armv7l)       | 665 Mbits/sec  | |
| OrangePi 5 / Rockchip rk3588s*   | Armbian 23.8.1 / 5.10.110        | 772 Mbits/sec  | |
| TP-Link XDR 6088 / MT7986        | OpenWRT 23.05.0 / 5.15.134       | 818 Mbits/sec  | |
| Raspberry Pi 4 / BCM2711*        | OpenWRT 23.05.2 / 5.15.137       | 1.01 Gbits/sec | |
| Raspberry Pi 4 / BCM2711*        | Raspberry Pi OS / 6.1.68         | 1.05 Gbits/sec | Reconfigure Kernel [#5](https://github.com/cyyself/wg-bench/issues/5) |
| HP T430 / Intel Celeron N4000    | Kiddin OpenWRT / 5.15.127        | 1.06 Gbits/sec | |
| Raspberry Pi 5 / BCM2712*        | Raspberry Pi OS / 6.1.63         | 1.13 Gbits/sec | |
| Mac Mini (2020) / Apple M1*      | AsahiLinux / 6.5.0               | 1.60 Gbits/sec | |
| Loongson-3A6000-HV               | LoongArchLinux / 6.6.0-rc4       | 1.85 Gbits/sec | |
| Phytium D2000x8 (2.3GHz)         | Debian bookworm / 6.1.66         | 2.05 Gbits/sec | |
| Intel Celeron(R) J4125           | Linux pve / 6.2.16               | 2.12 Gbits/sec | |
| Intel Xeon Silver 4210R          | Linux pve / 6.2.16               | 2.31 Gbits/sec | |
| OrangePi 5 / Rockchip rk3588s*   | Armbian23.8.1 / 5.10.110 / -R    | 2.35 Gbits/sec | |
| Intel Celeron N5105              | Debian bookworm / 6.1.38         | 2.46 Gbits/sec | |
| Intel Xeon Gold 6330             | Linux pve / 5.15.108             | 2.54 Gbits/sec | |
| AMD EPYC 7302                    | Debian bookworm / 6.1.55         | 2.69 Gbits/sec | |
| Raspberry Pi 5 / BCM2712*        | Raspberry Pi OS / 6.1.68         | 3.08 Gbits/sec | Reconfigure Kernel [#5](https://github.com/cyyself/wg-bench/issues/5) |
| Mac Mini (2020) / Apple M1*      | AsahiLinux / 6.5.0 / -R          | 3.62 Gbits/sec | |
| Intel Pentium(R) Silver N6005    | iStoreOS / 5.10.176              | 3.85 Gbits/sec | |
| Intel Core i5-4590               | Debian bookworm / 6.1.38         | 4.21 Gbits/sec | |
| AMD Ryzen 5 PRO 5650GE           | Linux pve / 6.2.16               | 5.29 Gbits/sec | |
| AMD Ryzen 9 7950X                | Ubuntu 22.04.3 / 5.15.0          | 5.64 Gbits/sec | |
| Intel Core i9 13900K             | Debian trixie / 6.5.13           | 7.53 Gbits/sec | |
| Intel Core i9 12900KS            | Ubuntu 22.04 / 6.2.0-32          | 8.30 Gbits/sec | |

If you have more results to show, PR is welcomed.

We recommend also testing with `-R` by `sudo ./benchmark.sh -R` before submitting the result.

If you see quite a difference in speed which might happen on BIG.little CPU architecture (such as Apple M1), please note this in your commit.

## About Result

This program only benchmarks your CPU and Kernel network stack, the end-to-end performance will also be affected by your NIC, NIC driver, etc.
