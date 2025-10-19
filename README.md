# luci-app-v2ray

Luci support for v2ray

**This branch is LuCI for OpenWrt 23.05 and later**

**For legacy version: [Branch legacy](https://github.com/coflery/luci-app-v2ray/tree/legacy)**

[![Release Version](https://img.shields.io/github/release/coflery/luci-app-v2ray.svg)](https://github.com/coflery/luci-app-v2ray/releases/latest)
[![Latest Release Download](https://img.shields.io/github/downloads/coflery/luci-app-v2ray/latest/total.svg)](https://github.com/coflery/luci-app-v2ray/releases/latest)
[![Total Download](https://img.shields.io/github/downloads/coflery/luci-app-v2ray/total.svg)](https://github.com/coflery/luci-app-v2ray/releases)

## Install

### Manual install

1. Download v2ray file from v2ray release [link](https://github.com/v2ray/v2ray-core/releases) 
   or v2ray ipk release [link](https://github.com/kuoruan/openwrt-v2ray/releases)

2. Upload files to your router

3. Install package with opkg:

```sh
opkg install luci-app-v2ray_*.ipk
```

Dependencies:

- jshn
- ip (ip-tiny or ip-full)
- ipset
- iptables
- iptables-mod-tproxy
- resolveip
- dnsmasq-full (dnsmasq ipset is required)

For translations, please install ```luci-i18n-v2ray-*```

> You may need to remove ```dnsmasq``` before installing this package

## Configure

1. Download v2ray file from v2ray release [link](https://github.com/v2ray/v2ray-core/releases)

2. Upload v2ray file to your router

3. Config v2ray file path in LuCI page

4. Add your inbound and outbound rules

5. Enable the service via LuCI

## Build

Package files is in branch [luci2](https://github.com/coflery/luci-app-v2ray/tree/luci2)

Download with Git:

```sh
git clone -b luci2 https://github.com/coflery/luci-app-v2ray.git luci-app-v2ray
```
