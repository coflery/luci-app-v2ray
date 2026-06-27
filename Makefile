#
# Copyright 2020 Xingwang Liao <kuoruan@gmail.com>
# Licensed to the public under the MIT License.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-v2ray
PKG_VERSION:=2.0.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_MAINTAINER:=Xingwang Liao <kuoruan@gmail.com>
PKG_BUILD_DEPENDS:=luci-base/host

PKG_FILE_MODES:=\
	/etc/init.d/v2ray:0755 \
	/etc/uci-defaults/40_luci-v2ray:0755 \
	/usr/libexec/rpcd/luci.v2ray:0755 \
	/usr/libexec/v2ray/v2ray_entry.sh:0755

LUCI_TITLE:=LuCI support for v2ray
LUCI_DEPENDS:=+jshn
LUCI_DEPENDS+=+ip
LUCI_DEPENDS+=+resolveip
LUCI_DEPENDS+=+dnsmasq-full
LUCI_DEPENDS+=+nftables
LUCI_DEPENDS+=+kmod-nft-core
LUCI_DEPENDS+=+kmod-nft-nat
LUCI_DEPENDS+=+kmod-nft-tproxy
LUCI_PKGARCH:=all

define Package/$(PKG_NAME)/conffiles
/etc/config/v2ray
/etc/v2ray/transport.json
/etc/v2ray/directlist.txt
/etc/v2ray/proxylist.txt
endef

include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)/postinst
#!/bin/sh

if [ -z "$${IPKG_INSTROOT}" ] ; then
	( . /etc/uci-defaults/40_luci-v2ray ) && rm -f /etc/uci-defaults/40_luci-v2ray

	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache/
	/etc/init.d/v2ray enable
	/etc/init.d/v2ray start

	killall -HUP rpcd 2>/dev/null
fi
exit 0
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh

if [ -s "$${IPKG_INSTROOT}/etc/rc.d/S99v2ray" ] ; then
	rm -f "$${IPKG_INSTROOT}/etc/rc.d/S99v2ray"
fi

if [ -z "$${IPKG_INSTROOT}" ] ; then
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache/
fi

exit 0
endef

# call BuildPackage - OpenWrt buildroot signature
