#
# Copyright 2020 Xingwang Liao <kuoruan@gmail.com>
# Licensed to the public under the MIT License.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=#{name}
PKG_VERSION:=#{version}
PKG_RELEASE:=#{release}

PKG_LICENSE:=#{license}
PKG_MAINTAINER:=#{author}
PKG_BUILD_DEPENDS:=luci-base/host

LUCI_TITLE:=#{description}
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

define Package/$(PKG_NAME)/install
	$(call LuCI/Install,$(1))

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/init.d/v2ray $(1)/etc/init.d/v2ray

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./root/etc/uci-defaults/40_luci-v2ray $(1)/etc/uci-defaults/40_luci-v2ray

	$(INSTALL_DIR) $(1)/usr/libexec/rpcd
	$(INSTALL_BIN) ./root/usr/libexec/rpcd/luci.v2ray $(1)/usr/libexec/rpcd/luci.v2ray

	$(INSTALL_DIR) $(1)/usr/libexec/v2ray
	$(INSTALL_BIN) ./root/usr/libexec/v2ray/v2ray_entry.sh $(1)/usr/libexec/v2ray/v2ray_entry.sh
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh

if [ -z "$${IPKG_INSTROOT}" ] ; then
	[ -f "/etc/uci-defaults/40_luci-v2ray" ] && \
		( . /etc/uci-defaults/40_luci-v2ray ) && rm -f /etc/uci-defaults/40_luci-v2ray

	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache/

	killall -HUP rpcd 2>/dev/null
fi

chmod 755 "$${IPKG_INSTROOT}/etc/init.d/v2ray" >/dev/null 2>&1
chmod 755 "$${IPKG_INSTROOT}/etc/uci-defaults/40_luci-v2ray" >/dev/null 2>&1
chmod 755 "$${IPKG_INSTROOT}/usr/libexec/rpcd/luci.v2ray" >/dev/null 2>&1
chmod 755 "$${IPKG_INSTROOT}/usr/libexec/v2ray/v2ray_entry.sh" >/dev/null 2>&1

ln -sf "../init.d/v2ray" \
	"$${IPKG_INSTROOT}/etc/rc.d/S99v2ray" >/dev/null 2>&1

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
