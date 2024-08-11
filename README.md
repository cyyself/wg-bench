# WireGuard Benchmark

Test WireGuard performance using netns and iperf3.

## How to use

On most distros, `wireguard-tools` and `iperf3` are the only two required packages.

On OpenWRT, packages `ip-full` and `kmod-veth` are also required.

```shell
sudo ./setup-netns.sh
sudo ./benchmark.sh
sudo ./clean-up.sh
```

### OpenWrt one-line script
```shell
sh <(wget -O - https://raw.githubusercontent.com/cyyself/wg-bench/master/openwrt-benchmark.sh)
```

## Test Results

\* refers to this device having quite a difference in speed with different configurations.

| Device / CPU                     | OS / Kernel / iperf Param        | Speed          | Note |
| -------------------------------- | -------------------------------- | -------------- | - |
| Toshiba Satellite 480CDT / Pentium MMX 233MHz | Alpine Linux 3.18 / 6.2.0-rc7 | 3.2 Mbits/sec   | |
| Raspberry Pi Model B / BCM2835   | OpenWrt 23.05.2 / 5.15.137       | 16.1 Mbits/sec | |
| Buffalo WCR-1166DS / MT7628AN    | OpenWrt 23.05.2 / 5.15.137       | 18.3 Mbits/sec | |
| GL-iNet MT300N V1 / MT7620N      | OpenWrt 23.05.2 / 5.15.137       | 19.2 Mbits/sec | |
| TP-Link WR841N v9 / QCA9533       | OpenWrt 22.03.6 / 5.10.201       | 19.2 Mbits/sec | |
| AVM FRITZ!Box 3490 / VRX288      | OpenWrt SNAPSHOT / 3.17.1        | 26.1 Mbits/sec | |
| GL-iNet MT1300 / MT7621A         | OpenWrt 23.05.2 / 5.15.137       | 82.5 Mbits/sec | |
| D-Team Newifi D2 / MT7621AT      | OpenWrt 23.05.2 / 5.15.137       | 93 Mbits/sec   | |
| Zyxel WSM20 / MT7621AT           | OpenWrt 23.05.2 / 5.15.137       | 98.3 Mbits/sec | |
| ASUS RT-AX53U / MT7621AT         | OpenWrt 23.05.2 / 5.15.137       | 98.9 Mbits/sec  | |
| Ubiquit EdgeRouter-X / MT7621AT  | OpenWrt 23.05.2 / 5.15.137       | 99 Mbits/sec   | |
| Beeline SmartBox GIGA / MT7621A  | OpenWrt 23.05.2 / 5.15.137       | 100 Mbits/sec  | |
| Beeline SmartBox PRO / MT7621AT  | OpenWrt 23.05.2 / 5.15.137       | 101 Mbits/sec  | |
| Beeline SmartBox TURBO+ / MT7621A | OpenWrt Snapshot / 5.15.148       | 104 Mbits/sec  | |
| TP-Link EC330-G5u V1 / MT7621A   | OpenWrt 23.05.2 / 5.15.137       | 104 Mbits/sec  | |
| Google WiFi (Gale) / IPQ4019     | OpenWrt 23.05.2 / 5.15.137       | 164 Mbits/sec  | |
| P&W R619AC 128M / IPQ4019     | OpenWrt 23.05.4 / 5.15.164       | 201 Mbits/sec  | Overclocked 896 MHz |
| Xiaomi Mi Router R3D / IPQ8064   | OpenWrt Snapshot / 6.1.77       | 214 Mbits/sec  | |
| NanoPi R2S / RK3328              | OpenWrt 23.05.2 / 5.15.137       | 234 Mbits/sec  | |
| Intel Atom E3825                 | OpenWrt 23.05.2 / 5.15.137       | 259 Mbits/sec  | |
| Netgear R7800 / IPQ8065          | OpenWrt 23.05.2 / 5.15.137       | 291 Mbits/sec  | |
| Phytium Pi (V2.2) / E2000Q FT310 (1.5GHz) | deepin V23 Beta3 / 5.10.209 | 358 Mbits/sec | With FT664 "big" cores disabled |
| Linksys WRT1900ACv2  / 88F6820   | OpenWrt 23.05.2 / 5.15.137       | 361 Mbits/sec  | |
| CMCC RAX3000M / MT7981           | OpenWRT 23.05.2 / 5.15.137       | 369 Mbits/sec  | |
| 360 T7 / MT7981                  | OpenWRT 23.05.0 / 5.15.134       | 369 Mbits/sec  | |
| GL-iNet MT3000 / MT7981          | GL 5.4.211 / 5.10.0              | 369 Mbits/sec  | |
| Xiaomi AX3000T / MT7981          | OpenWrt Snapshot / 6.1.82        | 371 Mbits/sec  | |
| OpenWrt One / MT7981             | OpenWrt Snapshot / 6.6.43        | 375 Mbits/sec  | |
| Routerich AX3000 / MT7981        | OpenWRT 23.05.2 / 5.15.137       | 381 Mbits/sec  | |
| Netgear WAX206 / MT7622          | OpenWRT 23.05.2 / 5.15.137       | 381 Mbits/sec  | |
| Redmi AX6S / MT7622              | OpenWRT 23.05.2 / 5.15.137       | 391 Mbits/sec  | |
| StarFive VisionFive 2 / JH7110   | Debian trixie / 5.15.0           | 402 Mbits/sec  | |
| Loongson 3A3000-LP               | Debian bookworm / 5.10.209       | 423 Mbits/sec  | CPU reversion variant H2, clocked at 1.45GHz |
| Linksys WRT3200ACM / 88F6820     | OpenWRT 23.05.2 / 5.15.137       | 426 Mbits/sec  | |
| Phytium Pi (V2.2) / E2000Q FT664 (1.8GHz) | deepin V23 Beta3 / 5.10.209 | 437 Mbits/sec  | With FT310 "little" cores disabled |
| Milk-V Pioneer / SG2042          | RevyOS / 6.1.61                  | 440 Mbits/sec  | |
| Raspberry Pi Zero 2W / BCM2710A1 | OpenWRT 23.05.2 / 5.15.137       | 443 Mbits/sec  | |
| Sipeed Lichee Pi 4A / TH1520     | RevyOS / 6.6.4                   | 451 Mbits/sec  | |
| Raspberry Pi Model 3B / BCM2837  | OpenWRT 23.05.2 / 5.15.137       | 522 Mbits/sec  | |
| Phicomm N1 / S905D               | ophub-openwrt / 6.1.66           | 537 Mbits/sec  | |
| Intel Celeron(R) J1800           | Ubuntu 22.04.3 / 5.15.0          | 551 Mbits/sec  | |
| Redmi AX6 / IPQ8071A             | OpenWRT Snapshot / 6.1.77        | 603 Mbits/sec  | |
| Radxa E20C / RK3528              | iStoreOS / 5.10.201              | 620 Mbits/sec  | |
| Raspberry Pi 4 / BCM2711*        | archlinux / 6.1.61(armv7l)       | 665 Mbits/sec  | |
| Mercusys MR90X v1 / MT7986       | OpenWRT 23.05.2 / 5.15.137       | 754 Mbits/sec  | |
| Intel Celeron N2930              | OpenWRT 23.05.2 / 5.15.137       | 762 Mbits/sec  | |
| OrangePi 5 / Rockchip rk3588s*   | Armbian 23.8.1 / 5.10.110        | 772 Mbits/sec  | |
| Asus TUF-AX6000 / MT7986AV       | OpenWRT Snapshot / 6.1.78        | 786 Mbits/sec  | |
| JDCloud RE-CP-03 / MT7986A*      | OpenWRT Snapshot / 6.1.82        | 788 Mbits/sec  | default openwrt firewall settings |
| Loongson 3A4000                  | Debian bookworm / 6.1.76         | 799 Mbits/sec  | |
| GL-iNet MT6000 / MT7986          | OpenWRT Snapshot / 6.1.78        | 807 Mbits/sec  | |
| TP-Link XDR 6088 / MT7986        | OpenWRT 23.05.0 / 5.15.134       | 818 Mbits/sec  | |
| Redmi AX6000 / MT7986A           | OpenWRT 23.05.3 / 5.15.150       | 820 Mbits/sec  | |
| Raspberry Pi 4 / BCM2711*        | OpenWRT 23.05.2 / 5.15.137       | 881 Mbits/sec  | CPU at 1.5GHz |
| Asus TUF-AX4200 / MT7986AV       | OpenWRT Snapshot / 6.1.78        | 936 Mbits/sec  | |
| JDCloud RE-CP-03 / MT7986A*      | OpenWRT Snapshot / 6.1.82        | 946 Mbits/sec  | with firewall disabled |
| Raspberry Pi 4 / BCM2711*        | OpenWRT 23.05.2 / 5.15.137       | 1.02 Gbits/sec | CPU at 2.0GHz |
| HP T430 / Intel Celeron N4000    | Kiddin OpenWRT / 5.15.127        | 1.06 Gbits/sec | |
| VMware Edge 620 / Intel Atom C3558 | Debian bookworm / 6.6.13-bpo   | 1.17 Gbits/sec | |
| Intel Atom C3558                 | Debian bookworm / 6.1.0-13       | 1.26 Gbits/sec | |
| Banana Pi BPI-R4 / MT7988A       | OpenWRT Snapshot / 6.1.77        | 1.27 Gbits/sec | |
| iEi Puzzle-M902 / Marvell CN9130 | OpenWRT 23.05.03 / 5.15.150      | 1.43 Gbits/sec | |
| Intel Celeron N4500              | Linux pve / 6.2.16-3-pve         | 1.54 Gbits/sec | |
| Mac Mini (2020) / Apple M1*      | AsahiLinux / 6.5.0               | 1.60 Gbits/sec | |
| Loongson-3A6000-HV               | LoongArchLinux / 6.6.0-rc4       | 1.85 Gbits/sec | |
| Phytium D2000x8 (2.3GHz)         | Debian bookworm / 6.1.66         | 2.05 Gbits/sec | |
| AMD EPYC 7742 (single socket)    | Debian bookworm / 6.1.27         | 2.10 Gbits/sec | |
| Intel Celeron(R) J4125           | Linux pve / 6.2.16               | 2.12 Gbits/sec | |
| Intel Xeon Silver 4210R          | Linux pve / 6.2.16               | 2.31 Gbits/sec | |
| OrangePi 5 / Rockchip rk3588s*   | Armbian23.8.1 / 5.10.110 / -R    | 2.35 Gbits/sec | |
| AMD EPYC 7D12                    | Linux pve / 6.2.16               | 2.45 Gbits/sec | |
| Intel Celeron N5105*             | Debian bookworm / 6.1.38         | 2.46 Gbits/sec | |
| Intel Xeon Gold 6330             | Linux pve / 5.15.108             | 2.54 Gbits/sec | |
| Raspberry Pi 5 / BCM2712         | Raspberry Pi OS / 6.1.68         | 2.60 Gbits/sec | |
| AMD EPYC 7302                    | Debian bookworm / 6.1.55         | 2.69 Gbits/sec | |
| Intel CC150                      | Linux pve / 6.5.13               | 2.78 Gbits/sec | |
| Intel Atom P5342                 | Debian bookworm / 6.1.0-16       | 2.89 Gbits/sec | |
| Intel Xeon E3-1265L v3           | Debian trixie / 6.6.13           | 3.03 Gbits/sec | |
| Raspberry Pi 5 / BCM2712*        | Raspberry Pi OS / 6.1.68         | 3.08 Gbits/sec | Reconfigure Kernel [#5](https://github.com/cyyself/wg-bench/issues/5) |
| Pixel 7a / Google Tensor G2      | Debian trixie / 6.1.2            | 3.14 Gbits/sec | 2 core pKVM |
| AMD Ryzen 9 5950X*               | Arch Linux / 6.7.6-arch1-1       | 3.28 Gbits/sec | [test 1 firewalld: running ; irqbalance: running](https://github.com/teelfox/wg-bench/blob/081895035183bdd03ee063f08efa307ecf7c0762/teelfox_ryzen_9_5950X.md) |
| Intel Atlas Canyon / Intel Celeron N5105* | Alpine Linux / 6.6.28            | 3.44 Gbits/sec | |
| AMD Ryzen 9 5950X*               | Arch Linux / 6.7.6-arch1-1       | 3.55 Gbits/sec | [test 5 firewalld: stopped ; irqbalance: running ; nftables](https://github.com/teelfox/wg-bench/blob/081895035183bdd03ee063f08efa307ecf7c0762/teelfox_ryzen_9_5950X.md) |
| Mac Mini (2020) / Apple M1*      | AsahiLinux / 6.5.0 / -R          | 3.62 Gbits/sec | |
| AMD Ryzen 9 5950X*               | Arch Linux / 6.7.6-arch1-1       | 3.63 Gbits/sec | [test 2 firewalld: running ; irqbalance: stopped](https://github.com/teelfox/wg-bench/blob/081895035183bdd03ee063f08efa307ecf7c0762/teelfox_ryzen_9_5950X.md) ; needs retesting [#1](https://github.com/teelfox/wg-bench/issues/1) |
| Intel Pentium(R) Silver N6005    | iStoreOS / 5.10.176              | 3.85 Gbits/sec | |
| Intel N100                       | Debian bookworm / 6.1.76         | 3.97 Gbits/sec | |
| AMD Ryzen 9 5950X*               | Arch Linux / 6.7.6-arch1-1       | 4.14 Gbits/sec | [test 4 firewalld: stopped ; irqbalance: stopped](https://github.com/teelfox/wg-bench/blob/081895035183bdd03ee063f08efa307ecf7c0762/teelfox_ryzen_9_5950X.md) |
| Intel Core i5-4590               | Debian bookworm / 6.1.38         | 4.21 Gbits/sec | |
| AMD Ryzen 9 5950X*               | Arch Linux / 6.7.6-arch1-1       | 4.30 Gbits/sec | [test 3 firewalld: stopped ; irqbalance: running](https://github.com/teelfox/wg-bench/blob/081895035183bdd03ee063f08efa307ecf7c0762/teelfox_ryzen_9_5950X.md) ; needs retesting [#1](https://github.com/teelfox/wg-bench/issues/1) |
| Intel Core i5-8500               | Ubuntu 22.04.3 / 5.15.0          | 4.49 Gbits/sec | |
| Intel N100                       | Debian bookworm / 6.6.13         | 4.65 Gbits/sec | CPU at 12W TDP |
| Intel Core i7-8565U              | Debian trixie / 6.7.6 xanmod     | 4.93 Gbits/sec | Xanmod Kernel |
| AMD Ryzen 5 PRO 5650GE           | Linux pve / 6.2.16               | 5.29 Gbits/sec | |
| AMD Ryzen 9 7950X                | Ubuntu 22.04.3 / 5.15.0          | 5.64 Gbits/sec | |
| Intel Core i5-8365U              | Debian bullseye / 5.10.0-24      | 5.64 Gbits/sec | |
| Intel Core i5-8265U              | Arch Linux / 6.10.1              | 6.00 Gbits/sec | |
| AMD Ryzen 9 7945HX               | Debian bookworm / 6.1.0          | 6.83 Gbits/sec | |
| Intel Core i9 13900K             | Debian trixie / 6.5.13           | 7.53 Gbits/sec | |
| AMD Ryzen 7 7840HS               | Arch Linux / 6.8.7-2-cachyos-bore-lto_v4 | 8.11 Gbits/sec| CachyOS Kernel|
| Intel Core i9 12900KS            | Ubuntu 22.04 / 6.2.0-32          | 8.30 Gbits/sec | |
| MacBook Pro 2023 / Apple M2 Max* | Debian bookworm / 6.7.4-1 | 9.30 Gbits/sec | 4 core VZ VM |
| MacBook Pro 2023 / Apple M3 Max* | Ubuntu 22.04 / 5.15.0-91 | 9.39 Gbits/sec | 4 core VM (Parallels Desktop 19.3.0) |
| Intel Core i9 13905H*            | Arch Linux / 6.10.3              | 10.5 Gbits/sec | |

If you have more results to show, PR is welcomed.

We recommend also testing with `-R` by `sudo ./benchmark.sh -R` before submitting the result.

If you see quite a difference in speed which might happen on big.LITTLE CPU architecture (such as Apple M1), please note this in your commit.

## About Result

This program only benchmarks your CPU and Kernel network stack, the end-to-end performance will also be affected by your NIC, NIC driver, etc.

## Discussion

[A Wireguard comparison DB on OpenWRT forum](https://forum.openwrt.org/t/a-wireguard-comparison-db/187586)
