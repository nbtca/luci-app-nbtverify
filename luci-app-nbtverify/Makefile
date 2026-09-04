include $(TOPDIR)/rules.mk

PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=GPL-2.0-only

LUCI_TITLE:=LuCI support for nbtverify
LUCI_DESCRIPTION:=Web interface for the nbtverify campus network authentication client.
LUCI_DEPENDS:=+nbtverify +luci-compat
LUCI_PKGARCH:=all
LUCI_URL:=https://github.com/nbtca/luci-app-nbtverify
LUCI_MAINTAINER:=nbtca <https://github.com/nbtca>

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
