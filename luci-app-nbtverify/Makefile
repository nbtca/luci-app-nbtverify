include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-nbtverify
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=nbtca <https://github.com/nbtca>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-nbtverify
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI support for nbtverify
	PKGARCH:=all
	DEPENDS:=+nbtverify +luci-base
endef

define Package/luci-app-nbtverify/description
	LuCI web interface for nbtverify campus network authentication client.
endef

define Build/Compile
endef

define Package/luci-app-nbtverify/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/nbtverify.lua \
		$(1)/usr/lib/lua/luci/controller/nbtverify.lua
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/nbtverify.lua \
		$(1)/usr/lib/lua/luci/model/cbi/nbtverify.lua
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/nbtverify_status.htm \
		$(1)/usr/lib/lua/luci/view/nbtverify_status.htm
endef

$(eval $(call BuildPackage,luci-app-nbtverify))
