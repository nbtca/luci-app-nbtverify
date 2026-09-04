# Feed integration

本仓库是一个标准的 OpenWrt feed，包含 `nbtverify` 和 `luci-app-nbtverify` 两个源码包；简体中文翻译包由 `luci.mk` 自动生成。

## 在完整源码树中使用

把以下内容加入 `feeds.conf`：

```text
src-git nbtverify https://github.com/nbtca/luci-app-nbtverify.git
```

安装 feed：

```sh
./scripts/feeds update nbtverify
./scripts/feeds install -a -p nbtverify
```

通过 `make menuconfig` 选择：

```text
Network  -> nbtverify
LuCI     -> Applications -> luci-app-nbtverify
Languages -> luci-i18n-nbtverify-zh-cn
```

也可以直接写入配置：

```sh
cat >> .config <<'EOF'
CONFIG_PACKAGE_nbtverify=m
CONFIG_PACKAGE_luci-app-nbtverify=m
CONFIG_PACKAGE_luci-i18n-nbtverify-zh-cn=m
EOF
make defconfig
```

构建：

```sh
make package/nbtverify/download V=s
make package/nbtverify/compile -j"$(nproc)" V=s
make package/feeds/luci/luci-base/host/compile -j"$(nproc)" V=s
make package/luci-app-nbtverify/compile -j"$(nproc)" V=s
```

## SDK 构建

必须使用与目标固件相同发行版、目标和 libc ABI 的 SDK。不要根据 CPU 名称混用 OpenWrt 与 ImmortalWrt SDK，也不要把 APK 与 IPK 混装。

当前 CI/验收目标是 ImmortalWrt 25.12.1 x86/64：

```text
https://downloads.immortalwrt.org/releases/25.12.1/targets/x86/64/
```

具体下载、SHA-256 校验和构建命令见 [README.md](README.md#使用匹配-sdk-构建)。

## 输出格式

- ImmortalWrt 25.12.1 使用 APK，文件名形如 `nbtverify-0.1.9-r1.apk`。
- 较旧的 24.10 构建树通常使用 IPK，文件名形如 `nbtverify_0.1.9-r1_x86_64.ipk`。

查找输出时以实际 SDK 为准：

```sh
find bin/packages -type f \( -name '*nbtverify*.apk' -o -name '*nbtverify*.ipk' \)
```

## 运行时依赖

`nbtverify`：

- `ca-bundle`
- `jshn`
- 由 `golang-package.mk` 生成的架构约束

`luci-app-nbtverify`：

- `nbtverify`
- `luci-compat`（旧式 Lua controller/CBI 的兼容运行时）

## 常见问题

### 包能构建但无法安装

先在目标设备检查：

```sh
cat /etc/openwrt_release
command -v apk || command -v opkg
apk --print-arch 2>/dev/null || opkg print-architecture
```

发行版、版本、包格式和架构都应与 SDK 输出一致。纯用户态包不依赖 kernel vermagic，但仍不能忽略 libc 和包管理器差异。

### LuCI 菜单未出现

确认 `luci-app-nbtverify` 和 `luci-compat` 已安装，然后执行：

```sh
rm -f /tmp/luci-indexcache.*
rm -rf /tmp/luci-modulecache/
/etc/init.d/rpcd reload
```

正常安装时，`luci.mk` 生成的 post-install 脚本会自动完成这些操作。
