include $(TOPDIR)/rules.mk

PKG_NAME:=nbtverify
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/nbtca/nbtverify.git
PKG_SOURCE_VERSION:=HEAD
PKG_MIRROR_HASH:=skip

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=nbtca <https://github.com/nbtca>

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/nbtca/nbtverify
GO_PKG_BUILD_PKG:=$(GO_PKG)
GO_PKG_LDFLAGS_X:=main.version=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/nbtverify
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Campus network authentication client
	URL:=https://github.com/nbtca/nbtverify
	DEPENDS:=$(GO_ARCH_DEPENDS) +ipset +dnsmasq-full +curl
endef

define Package/nbtverify/description
	NBTVerify is a campus network authentication client for OpenWrt.
endef

define Package/nbtverify/conffiles
/etc/config/nbtverify
endef

define Package/nbtverify/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/nbtverify $(1)/usr/bin/nbtverify
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/nbtverify $(1)/etc/config/nbtverify
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/nbtverify $(1)/etc/init.d/nbtverify
endef

$(eval $(call GoBinPackage,nbtverify))
$(eval $(call BuildPackage,nbtverify))
