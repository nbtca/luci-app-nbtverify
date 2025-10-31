# OpenWrt Feed Configuration

This repository can be added as a custom feed to your OpenWrt buildroot or used directly with OpenWrt SDK.

## Method 1: Add as Custom Feed

### Step 1: Edit feeds.conf.default

Add the following line to your `feeds.conf.default` or `feeds.conf`:

```
src-git nbtverify https://github.com/nbtca/luci-app-nbtverify.git
```

Or use a specific branch:

```
src-git nbtverify https://github.com/nbtca/luci-app-nbtverify.git;main
```

### Step 2: Update and Install Feeds

```bash
./scripts/feeds update nbtverify
./scripts/feeds install -a -p nbtverify
```

### Step 3: Select Packages in menuconfig

```bash
make menuconfig
```

Navigate to:
- `Network` → `nbtverify` - Enable the main package
- `LuCI` → `Applications` → `luci-app-nbtverify` - Enable the LuCI interface

### Step 4: Build

```bash
make package/nbtverify/compile V=s
make package/luci-app-nbtverify/compile V=s
```

Or build the entire firmware:

```bash
make -j$(nproc)
```

## Method 2: Use with OpenWrt SDK

### Step 1: Download SDK

Download the OpenWrt SDK for your target from:
https://downloads.openwrt.org/

Example for x86_64:
```bash
wget https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-sdk-x86-64_gcc-13.3.0_musl.Linux-x86_64.tar.xz
tar xf openwrt-sdk-x86-64_gcc-13.3.0_musl.Linux-x86_64.tar.xz
cd openwrt-sdk-x86-64_gcc-13.3.0_musl.Linux-x86_64
```

### Step 2: Update Feeds

```bash
./scripts/feeds update -a
./scripts/feeds install -a
./scripts/feeds install golang
```

### Step 3: Copy Packages

```bash
git clone https://github.com/nbtca/luci-app-nbtverify.git
cp -r luci-app-nbtverify/nbtverify package/
cp -r luci-app-nbtverify/luci-app-nbtverify package/
```

### Step 4: Build

```bash
make package/nbtverify/compile V=s
make package/luci-app-nbtverify/compile V=s
```

### Step 5: Find Packages

Compiled packages will be in:
```
bin/packages/*/base/nbtverify_*.ipk
bin/packages/*/luci/luci-app-nbtverify_*.ipk
```

## Method 3: Use Pre-built Packages

Download pre-built packages from the [Releases](https://github.com/nbtca/luci-app-nbtverify/releases) page.

## Supported Architectures

- x86_64 (Intel/AMD 64-bit)
- arm_cortex-a9 (BCM53xx, IPQ40xx, etc.)
- arm_cortex-a7_neon-vfpv4
- aarch64_cortex-a53 (ARM64)
- mipsel_24kc (Ramips MT7621, etc.)
- And more...

## Dependencies

### For nbtverify package:
- golang (build-time only)
- ipset
- dnsmasq-full
- curl

### For luci-app-nbtverify:
- nbtverify
- luci-base

## Troubleshooting

### Go Build Fails

Make sure golang feed is properly installed:
```bash
./scripts/feeds update packages
./scripts/feeds install golang
```

### Missing Dependencies

Install required feeds:
```bash
./scripts/feeds update -a
./scripts/feeds install -a
```

### Package Not Found in menuconfig

Make sure the feed is properly updated and packages are installed:
```bash
./scripts/feeds update nbtverify
./scripts/feeds install -a -p nbtverify
```

## Contributing

For build system improvements or bug reports, please open an issue or pull request at:
https://github.com/nbtca/luci-app-nbtverify
