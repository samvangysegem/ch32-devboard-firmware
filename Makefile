# Build dir
BUILD_DIR := build

# Toolchain
TOOLCHAIN_FILE := cmake/riscv32.none.elf.cmake
TOOLCHAIN_PATH := $(abspath toolchain/install)

# Project targets
.PHONY: all config build compile clean toolchain flash probe debug-server debug-client

# Default target
all: config compile

######################
# Project
######################

config:
	-@mkdir $(BUILD_DIR)
	cmake -S . -B $(BUILD_DIR) -G Ninja \
    --toolchain $(TOOLCHAIN_FILE) \
    -DTOOLCHAIN_PATH=$(TOOLCHAIN_PATH)

build: config
	cmake --build $(BUILD_DIR)

# Assumes config step completed
compile:
	cmake --build $(BUILD_DIR)

clean:
	@rm -rf $(BUILD_DIR)

######################
# Flash
######################

OPENOCD   := ./openocd.wch/bin/openocd
FLASH_CFG := flash/ch32v305-wchlink.cfg
BINARY    := $(BUILD_DIR)/app/ch32-devboard-firmware.bin
ELF       := $(BUILD_DIR)/app/ch32-devboard-firmware
LLDB      := $(TOOLCHAIN_PATH)/bin/lldb

# Unpack WCH OpenOCD; skipped automatically if already unpacked
openocd.wch/bin/openocd:
	tar -xzf openocd.wch.tar.gz

# Probe SDI chain — run this first to confirm WCH-LinkE sees the target
probe: openocd.wch/bin/openocd
	$(OPENOCD) -f $(FLASH_CFG) -c "init; shutdown"

flash: openocd.wch/bin/openocd $(BINARY)
	$(OPENOCD) -f $(FLASH_CFG) \
	    -c "program $(BINARY) 0x08000000 verify reset exit"

# Start OpenOCD as a GDB server (port 3333); run before debug-client
debug-server: openocd.wch/bin/openocd
	$(OPENOCD) -f $(FLASH_CFG) -c "init; reset halt"

# Attach LLDB to the running OpenOCD GDB server
debug-client: openocd.wch/bin/openocd $(ELF)
	$(LLDB) $(ELF) -o "gdb-remote localhost:3333"

######################
# Toolchain
######################

# Build
toolchain:
	git submodule update --init --recursive toolchain
	$(MAKE) -C toolchain clean all
