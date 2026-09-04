include $(TOPDIR)/rules.mk

PKG_NAME:=nbtverify
PKG_VERSION:=0.1.9
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/nbtca/nbtverify/tar.gz/refs/tags/v$(PKG_VERSION)?
PKG_HASH:=96d39232da123a1fcee527e0f697e5fb83f305fba39dd4ba6b39e332bdbaac41

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=nbtca <https://github.com/nbtca>

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=github.com/nbtca/nbtverify

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/nbtverify
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Campus network authentication client
	URL:=https://github.com/nbtca/nbtverify
	DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle +jshn
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
