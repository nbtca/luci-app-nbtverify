# luci-app-nbtverify

校园网认证 for OpenWrt - Campus Network Authentication Client for OpenWrt

## Overview

This repository contains OpenWrt packages for nbtverify, a campus network authentication client. It includes:

1. **nbtverify** - The main authentication client (compiled from upstream https://github.com/nbtca/nbtverify)
2. **luci-app-nbtverify** - Web interface for LuCI

## Features

- Automatic campus network authentication
- Web-based configuration through LuCI
- Support for multiple architectures (x86_64, ARM, MIPS, etc.)
- OpenWrt standard build system compatible
- GitHub Actions automatic compilation

## Installation

### Pre-built Packages

Download the latest pre-built `.ipk` packages from the [Releases](https://github.com/nbtca/luci-app-nbtverify/releases) page.

Install using opkg:
```bash
opkg update
opkg install nbtverify_*.ipk
opkg install luci-app-nbtverify_*.ipk
```

### Build from Source

#### Using OpenWrt SDK

See [FEED.md](FEED.md) for detailed instructions on using this package with OpenWrt SDK or as a custom feed.

Quick start:
1. Download and extract OpenWrt SDK for your architecture
2. Clone this repository:
```bash
cd openwrt-sdk
git clone https://github.com/nbtca/luci-app-nbtverify.git
```

3. Update feeds and install dependencies:
```bash
./scripts/feeds update -a
./scripts/feeds install -a
./scripts/feeds install golang
```

4. Copy packages to SDK:
```bash
cp -r luci-app-nbtverify/nbtverify package/
cp -r luci-app-nbtverify/luci-app-nbtverify package/
```


4. Build the packages:
```bash
make package/nbtverify/compile V=s
make package/luci-app-nbtverify/compile V=s
```

5. Find the packages in `bin/packages/*/`

#### Using OpenWrt Buildroot

See [FEED.md](FEED.md) for detailed instructions.

Quick start:
1. Clone OpenWrt buildroot:
```bash
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
```

2. Add this repository as a feed in `feeds.conf.default`:
```
src-git nbtverify https://github.com/nbtca/luci-app-nbtverify.git
```

3. Update feeds and install packages:
```bash
./scripts/feeds update -a
./scripts/feeds install -a
./scripts/feeds install nbtverify luci-app-nbtverify
```


4. Configure and build:
```bash
make menuconfig  # Select nbtverify and luci-app-nbtverify
make package/nbtverify/compile V=s
make package/luci-app-nbtverify/compile V=s
```

## Configuration

After installation, access the LuCI web interface:

1. Navigate to **Services** → **nbtverify**
2. Enter your credentials:
   - Username
   - Password
   - Mobile number (optional)
   - Ping URL (optional)
3. Enable the service
4. Click **Save & Apply**

## Package Structure

```
.
├── nbtverify/              # Main authentication client package
│   ├── Makefile            # Build instructions for nbtverify
│   └── files/              # Configuration and init scripts
│       ├── etc/
│       │   ├── config/     # UCI configuration
│       │   └── init.d/     # Init script
└── luci-app-nbtverify/     # LuCI web interface
    ├── Makefile            # Build instructions for LuCI app
    └── files/              # LuCI interface files
        └── usr/lib/lua/luci/
            ├── controller/  # Page controller
            ├── model/cbi/   # Configuration UI
            └── view/        # Custom views
```

## Development

### Prerequisites

- OpenWrt SDK or buildroot
- Go 1.19+ (for building nbtverify)
- Basic knowledge of OpenWrt package system

### Testing

Build and test locally using OpenWrt SDK or in a VM/container with OpenWrt.

## CI/CD

This repository uses GitHub Actions for automatic compilation:

- **Build on push**: Automatically builds packages for multiple architectures
- **Release on tag**: Creates GitHub releases with pre-built packages when a new tag is pushed

Supported architectures:
- x86_64
- ARM (Cortex-A9, Cortex-A7, Aarch64)
- MIPS/MIPSel

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

GPL-2.0

## Credits

- Upstream project: https://github.com/nbtca/nbtverify
- Maintainer: nbtca

## Screenshot

![LuCI Interface](https://github.com/user-attachments/assets/803a04e3-25de-4517-84e5-24d5fe66df05)

