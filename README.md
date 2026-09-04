# luci-app-nbtverify

适用于 ImmortalWrt / OpenWrt 的校园网认证客户端及 LuCI 管理界面。

仓库包含三个安装包：

- `nbtverify`：从上游 [nbtca/nbtverify](https://github.com/nbtca/nbtverify) v0.1.9 构建的 Go 客户端
- `luci-app-nbtverify`：兼容当前 LuCI 的 Lua CBI 管理界面
- `luci-i18n-nbtverify-zh-cn`：简体中文翻译

## 已验证目标

CI 和本地验收固定使用：

- ImmortalWrt 25.12.1
- `x86/64`、包架构 `x86_64`
- APK 包管理器
- ImmortalWrt 25.12.1 官方 SDK（GCC 14.3.0 / musl）

这与 `lk_x86_64-v3_immwrt` 的 2026-08-30 镜像版本一致。`x86-64-v3` 设备可以运行 SDK 生成的通用 `x86_64` 用户态程序。

## 安装

从 [Releases](https://github.com/nbtca/luci-app-nbtverify/releases) 下载同一构建中的三个 APK 和 `SHA256SUMS`，校验后安装：

```sh
sha256sum -c SHA256SUMS
apk add --allow-untrusted \
  ./nbtverify-*.apk \
  ./luci-app-nbtverify-*.apk \
  ./luci-i18n-nbtverify-zh-cn-*.apk
```

这里的 Release APK 没有加入设备的软件源签名链，因此本地文件安装需要 `--allow-untrusted`。不要把 25.12.1 的 APK 安装到使用 `opkg` 的 24.10 系统；此类系统应使用对应版本 SDK 重新构建 IPK。

安装后进入 **服务 → NBT Verify**，填写用户名、密码和认证模式，再启用服务。默认配置保持禁用，避免空凭据导致反复重启。

命令行检查：

```sh
/etc/init.d/nbtverify enable
/etc/init.d/nbtverify restart
/etc/init.d/nbtverify status
ubus call service list '{"name":"nbtverify"}'
```

## 使用匹配 SDK 构建

先安装常见 OpenWrt 构建依赖以及 `zstd`。然后下载并校验目标 SDK：

```sh
SDK=immortalwrt-sdk-25.12.1-x86-64_gcc-14.3.0_musl.Linux-x86_64.tar.zst
SDK_URL=https://downloads.immortalwrt.org/releases/25.12.1/targets/x86/64

wget "$SDK_URL/$SDK"
echo '02ad8cfc775001ccae8e9282d19696de54e3ab3963f005737ad61f8698263edd *'"$SDK" \
  | sha256sum -c --strict
mkdir immortalwrt-sdk
tar --zstd -xf "$SDK" -C immortalwrt-sdk --strip-components=1
cd immortalwrt-sdk
```

准备 feeds 和本仓库：

```sh
./scripts/feeds update -a
./scripts/feeds install -a

git clone https://github.com/nbtca/luci-app-nbtverify.git ../nbtverify-feed
cp -a ../nbtverify-feed/nbtverify package/nbtverify
cp -a ../nbtverify-feed/luci-app-nbtverify package/luci-app-nbtverify
```

配置并构建：

```sh
cat > .config <<'EOF'
CONFIG_PACKAGE_nbtverify=m
CONFIG_PACKAGE_luci-app-nbtverify=m
CONFIG_PACKAGE_luci-i18n-nbtverify-zh-cn=m
EOF

make defconfig
make package/nbtverify/download V=s
make package/nbtverify/compile -j"$(nproc)" V=s
make package/feeds/luci/luci-base/host/compile -j"$(nproc)" V=s
make package/luci-app-nbtverify/compile -j"$(nproc)" V=s

find bin/packages -type f \
  \( -name 'nbtverify-*.apk' \
     -o -name 'luci-app-nbtverify-*.apk' \
     -o -name 'luci-i18n-nbtverify-zh-cn-*.apk' \)
```

更完整的 feed 接入方法见 [FEED.md](FEED.md)。

## 实现说明

- 旧式 Lua controller/CBI 通过 `luci-compat` 运行，LuCI 包使用官方 `luci.mk` 构建。
- 服务凭据写入权限为 `0600` 的 `/var/run/nbtverify/*.json`，不出现在进程命令行中。
- LuCI 状态接口只返回页面需要的白名单字段，不返回上游状态文件中的 Cookie 和表单。
- 状态页用 DOM 文本节点显示门户返回值，避免把外部内容作为 HTML 执行。
- 打包补丁为上游 HTTP 请求增加 30 秒超时，并修复 POST 失败时的空指针崩溃。

## License

GPL-2.0-only
