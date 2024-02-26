# Wireguard benchmark

Benchmark date: 2024-02-24

Tested using <https://github.com/cyyself/wg-bench>

## Test machine data

### Hardware

Cpupower scheduler used `schedutil`.

#### CPU

```txt
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         48 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  32
  On-line CPU(s) list:   0-31
Vendor ID:               AuthenticAMD
  BIOS Vendor ID:        Advanced Micro Devices, Inc.
  Model name:            AMD Ryzen 9 5950X 16-Core Processor
    BIOS Model name:     AMD Ryzen 9 5950X 16-Core Processor             Unknown CPU @ 3.4GHz

Virtualization features: 
  Virtualization:        AMD-V
```

#### MOBO

```txt
Base Board Information
	Manufacturer: ASUSTeK COMPUTER INC.
	Product Name: ROG CROSSHAIR VIII DARK HERO
	Version: Rev X.0x
```

### OS-Release

```txt
cat /etc/os-release 
NAME="Arch Linux"
PRETTY_NAME="Arch Linux"
ID=arch
BUILD_ID=rolling
ANSI_COLOR="38;2;23;147;209"
HOME_URL="https://archlinux.org/"
DOCUMENTATION_URL="https://wiki.archlinux.org/"
SUPPORT_URL="https://bbs.archlinux.org/"
BUG_REPORT_URL="https://gitlab.archlinux.org/groups/archlinux/-/issues"
PRIVACY_POLICY_URL="https://terms.archlinux.org/docs/privacy-policy/"
LOGO=archlinux-logo
```

### Kernel version

```txt
uname -r
6.7.6-arch1-1
```

### Packages version:

```txt
pacman -Q irqbalance
irqbalance 1.9.3-2

pacman -Q firewalld
firewalld 2.1.1-1

pacman -Q nftables
nftables 1:1.0.9-1
```

### Firewalld configuration

```txt
drop (default, active)
  target: DROP
  ingress-priority: 0
  egress-priority: 0
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh syncthing
  ports: 
  protocols: icmp ipv6-icmp
  forward: no
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
	rule family="ipv4" source address="XXX" service name="zabbix-agent" accept
```

### IPv4 sysctls which may impact test results

```txt
net.core.wmem_default = 2097152
net.core.wmem_max = 33554432
net.ipv4.tcp_wmem = 32768 65536 33554432
net.ipv4.tcp_rmem=32768 2097152 33554432
net.core.rmem_default = 2097152
net.core.rmem_max = 33554432
net.ipv4.tcp_rmem = 32768 2097152 33554432
net.ipv4.udp_rmem_min = 8192
net.ipv4.udp_wmem_min = 8192
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mtu_probing = 1
net.core.default_qdisc = cake
net.ipv4.tcp_congestion_control = bbr
net.ipv4.conf.all.forwarding = 0
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.log_martians = 1
net.ipv4.ip_forward = 0
```

## Testing

### Test 1

firewald: running  
irqbalance: running

---

```txt
Connecting to host 169.254.200.2, port 5201
[  5] local 169.254.200.1 port 43636 connected to 169.254.200.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   394 MBytes  3.30 Gbits/sec    0    393 KBytes       
[  5]   1.00-2.00   sec   382 MBytes  3.21 Gbits/sec    0    337 KBytes       
[  5]   2.00-3.00   sec   391 MBytes  3.28 Gbits/sec    0    484 KBytes       
[  5]   3.00-4.00   sec   385 MBytes  3.23 Gbits/sec    0    339 KBytes       
[  5]   4.00-5.00   sec   386 MBytes  3.24 Gbits/sec    0    460 KBytes       
[  5]   5.00-6.00   sec   394 MBytes  3.30 Gbits/sec    0    347 KBytes       
[  5]   6.00-7.00   sec   397 MBytes  3.33 Gbits/sec    0    446 KBytes       
[  5]   7.00-8.00   sec   392 MBytes  3.29 Gbits/sec    0    315 KBytes       
[  5]   8.00-9.00   sec   394 MBytes  3.30 Gbits/sec    0    395 KBytes       
[  5]   9.00-10.00  sec   392 MBytes  3.28 Gbits/sec    0   5.34 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  3.81 GBytes  3.28 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  3.81 GBytes  3.27 Gbits/sec                  receiver
```

Test repeated three times, lowest score: `3.22 Gbits/sec`, highest `3.28 Gbits/sec`.

---

### Test 2

firewalld: running  
irqbalance: stopped

```txt
Connecting to host 169.254.200.2, port 5201
[  5] local 169.254.200.1 port 39528 connected to 169.254.200.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   439 MBytes  3.68 Gbits/sec    0    294 KBytes       
[  5]   1.00-2.00   sec   434 MBytes  3.64 Gbits/sec    0    291 KBytes       
[  5]   2.00-3.00   sec   434 MBytes  3.64 Gbits/sec    0    329 KBytes       
[  5]   3.00-4.00   sec   432 MBytes  3.63 Gbits/sec    0    286 KBytes       
[  5]   4.00-5.00   sec   433 MBytes  3.63 Gbits/sec    0    291 KBytes       
[  5]   5.00-6.00   sec   432 MBytes  3.62 Gbits/sec    0    283 KBytes       
[  5]   6.00-7.00   sec   432 MBytes  3.63 Gbits/sec    0    289 KBytes       
[  5]   7.00-8.00   sec   431 MBytes  3.62 Gbits/sec    0    289 KBytes       
[  5]   8.00-9.00   sec   432 MBytes  3.62 Gbits/sec    0    315 KBytes       
[  5]   9.00-10.00  sec   432 MBytes  3.62 Gbits/sec    0   5.34 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  4.23 GBytes  3.63 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  4.23 GBytes  3.63 Gbits/sec                  receiver
```

Test repeated three times, lowest score: `3.23 Gbits/sec`, highest `3.63 Gbits/sec`.

---

### Test 3

firewalld: stopped  
irqbalance: running

```txt
Connecting to host 169.254.200.2, port 5201
[  5] local 169.254.200.1 port 44872 connected to 169.254.200.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   525 MBytes  4.40 Gbits/sec    0    321 KBytes       
[  5]   1.00-2.00   sec   518 MBytes  4.35 Gbits/sec    0    315 KBytes       
[  5]   2.00-3.00   sec   515 MBytes  4.32 Gbits/sec    0    323 KBytes       
[  5]   3.00-4.00   sec   518 MBytes  4.34 Gbits/sec    0    345 KBytes       
[  5]   4.00-5.00   sec   510 MBytes  4.28 Gbits/sec    0    331 KBytes       
[  5]   5.00-6.00   sec   508 MBytes  4.26 Gbits/sec    0    323 KBytes       
[  5]   6.00-7.00   sec   506 MBytes  4.25 Gbits/sec    0    313 KBytes       
[  5]   7.00-8.00   sec   507 MBytes  4.25 Gbits/sec    0    342 KBytes       
[  5]   8.00-9.00   sec   506 MBytes  4.25 Gbits/sec    0    342 KBytes       
[  5]   9.00-10.00  sec   510 MBytes  4.28 Gbits/sec    0    321 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  5.00 GBytes  4.30 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  5.00 GBytes  4.30 Gbits/sec                  receiver
```

Test repeated three times, lowest score: `3.98 Gbits/sec`, highest `4.30 Gbits/sec`

---

### Test 4

firewalld: stopped  
irqbalance: stopped

```txt
Connecting to host 169.254.200.2, port 5201
[  5] local 169.254.200.1 port 44488 connected to 169.254.200.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   499 MBytes  4.18 Gbits/sec    0    428 KBytes       
[  5]   1.00-2.00   sec   490 MBytes  4.11 Gbits/sec    0    387 KBytes       
[  5]   2.00-3.00   sec   488 MBytes  4.10 Gbits/sec    0    286 KBytes       
[  5]   3.00-4.00   sec   488 MBytes  4.09 Gbits/sec    0    521 KBytes       
[  5]   4.00-5.00   sec   488 MBytes  4.09 Gbits/sec    0    382 KBytes       
[  5]   5.00-6.00   sec   487 MBytes  4.09 Gbits/sec    0    401 KBytes       
[  5]   6.00-7.00   sec   482 MBytes  4.04 Gbits/sec    0    387 KBytes       
[  5]   7.00-8.00   sec   491 MBytes  4.12 Gbits/sec    0    347 KBytes       
[  5]   8.00-9.00   sec   511 MBytes  4.29 Gbits/sec    0    315 KBytes       
[  5]   9.00-10.00  sec   513 MBytes  4.31 Gbits/sec    0    334 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  4.82 GBytes  4.14 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  4.82 GBytes  4.14 Gbits/sec                  receiver
```

Test repeated three times, lowest score: `3.94 Gbits/sec`, highest score `4.14 Gbits/sec`.

### Test 5

firewalld: stopped  
irqbalance: running  
nftables: small config allowing same ports/service as firewalld, with input policy set to drop

```txt
Connecting to host 169.254.200.2, port 5201
[  5] local 169.254.200.1 port 50292 connected to 169.254.200.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   420 MBytes  3.52 Gbits/sec    0    355 KBytes       
[  5]   1.00-2.00   sec   421 MBytes  3.53 Gbits/sec    0    395 KBytes       
[  5]   2.00-3.00   sec   420 MBytes  3.52 Gbits/sec    0    403 KBytes       
[  5]   3.00-4.00   sec   420 MBytes  3.53 Gbits/sec    0    305 KBytes       
[  5]   4.00-5.00   sec   425 MBytes  3.57 Gbits/sec    0    358 KBytes       
[  5]   5.00-6.00   sec   424 MBytes  3.55 Gbits/sec    0    323 KBytes       
[  5]   6.00-7.00   sec   429 MBytes  3.60 Gbits/sec    0    374 KBytes       
[  5]   7.00-8.00   sec   423 MBytes  3.55 Gbits/sec    0    454 KBytes       
[  5]   8.00-9.00   sec   428 MBytes  3.59 Gbits/sec    0    294 KBytes       
[  5]   9.00-10.00  sec   428 MBytes  3.59 Gbits/sec    0    548 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  4.14 GBytes  3.55 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  4.14 GBytes  3.55 Gbits/sec                  receiver
```

Test repeated three times, lowest score: `3.44 Gbits/sec`, highest score `3.55 Gbits/sec`.

## Conclusions

Wireguard is great. Period.

Firewalld ~~suc**~~ is not so great with it's rules. Pure nftables firewalling gives consistently better test result and is, in fact, more flexible then firewalld. Note to myself: switch back to `nftables`. They are simply better.

If/when I'll have some time I'll try to repeat tests with different, or at least, default sysctl settings (it may take long time before I'll do that). Maybe I'll also test different CPU schedulers.
