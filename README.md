# CH32 Development Board

This repository contains a firmware template, including toolchain, startup and linker files, for the CH32 development board.

## Status

Development on this project stopped due to lack of proper flashing device. Since SDI and SWD are incompatible, a J-Link cannot be used and the flashing connector is most likely incompatible with the proprietary flashing device as well. It was a fun project for HW design and FW / toolchain setup but I will direct my energy towards other projects...

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
