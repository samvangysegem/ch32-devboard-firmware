# Build dir
BUILD_DIR := build

# Toolchain
TOOLCHAIN_FILE := cmake/riscv32.none.elf.cmake
TOOLCHAIN_PATH := $(abspath toolchain/install)

# Project targets
.PHONY: all config build compile clean toolchain

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
# Toolchain
######################

# Build
toolchain:
	git submodule update --init --recursive toolchain
	$(MAKE) -C toolchain clean all
