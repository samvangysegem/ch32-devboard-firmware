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
