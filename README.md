# CH32 Development Board

This repository contains a firmware template, including toolchain, startup and linker files, for the CH32 development board.

## Setup

### Toolchain

You have two options to provide a toolchain:

1. **Build from source**
   ```bash
   make toolchain
   ```

2. **Symlink llvm toolchain**\
   ```bash
   ln -s /path/to/your/llvm toolchain/install
   ```

### Firmware

```bash
make build
```

## Flashing

Requires OpenOCD ≥ 0.12 and a WCH-LinkE connected to the board SDI header (SWCLK, SWDIO).

```bash
brew install open-ocd   # if not already installed
make probe              # verify WCH-LinkE sees the target
make flash
```
