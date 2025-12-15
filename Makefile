# Default build directory
BUILD_DIR := build

# Toolchain
TOOLCHAIN_FILE := cmake/riscv.none.elf.cmake
TOOLCHAIN_PATH := $(abspath toolchain/riscv-none-elf)

# Project targets
.PHONY: all config build clean

# Default target
all: config build

# Configure project
config:
	-mkdir $(BUILD_DIR)
	cmake -S . -B $(BUILD_DIR) -G Ninja \
		--toolchain $(TOOLCHAIN_FILE) \
		-DTOOLCHAIN_PATH=$(TOOLCHAIN_PATH)

# Build project
build: config
	cmake --build $(BUILD_DIR)

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

