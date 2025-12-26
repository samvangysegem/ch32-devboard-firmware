# Build dir
BUILD_DIR := build.app

# Toolchain
TOOLCHAIN_FILE := cmake/riscv.none.elf.cmake
TOOLCHAIN_PATH := $(abspath toolchain/riscv-none-elf)

# External libs
EXT_LIBS_BUILD_DIR := build.libs.extern

# External libs - Picolibc
PICOLIBC_BUILD_DIR := $(abspath $(EXT_LIBS_BUILD_DIR)/picolibc.build)
PICOLIBC_INSTALL_DIR := $(abspath $(EXT_LIBS_BUILD_DIR)/picolibc.install)

# Project targets
.PHONY: all config build compile clean

# Default target
all: config compile

######################
# Project
######################

config:
	-@mkdir $(BUILD_DIR)
	cmake -S . -B $(BUILD_DIR) -G Ninja \
    --toolchain $(TOOLCHAIN_FILE) \
    -DTOOLCHAIN_PATH=$(TOOLCHAIN_PATH) \
    -DLIBC_PATH=$(PICOLIBC_INSTALL_DIR)

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

.PHONY: toolchain

# Build
toolchain:
	git submodule update --init --recursive toolchain
	$(MAKE) -C toolchain clean install-riscv-none-elf

######################
# Extern Libs
######################

.PHONY: clean-libs config-picolibc build-picolibc clean-picolibc

clean-libs:
	@rm -rf $(EXT_LIBS_BUILD_DIR)

# Picolibc
PICOLIBC_SOURCE_DIR := $(abspath libs.extern/picolibc)
PICOLIBC_CROSS_FILE_TEMPLATE := meson/picolibc.cross.ini.in
PICOLIBC_CROSS_FILE := $(abspath $(PICOLIBC_BUILD_DIR)/picolibc.cross.ini)

$(PICOLIBC_CROSS_FILE): $(PICOLIBC_CROSS_FILE_TEMPLATE)
	-@mkdir -p $(PICOLIBC_BUILD_DIR)
	@echo "Generating cross-file: $(CROSS_FILE)"
	@sed -e 's|@TOOLCHAIN_PATH@|$(TOOLCHAIN_PATH)|g' \
    $(PICOLIBC_CROSS_FILE_TEMPLATE) > $(PICOLIBC_CROSS_FILE)

# When multilib disabled, arch and abi need to be added to
# compile args in cross file
# When multilib enabled, args are provided through compiler:
# `clang -target riscv32-none-elf --print-multi-lib`
config-picolibc: $(PICOLIBC_CROSS_FILE)
	cd $(PICOLIBC_BUILD_DIR) && \
  meson setup --cross-file $(PICOLIBC_CROSS_FILE) \
    --prefix=$(PICOLIBC_INSTALL_DIR) \
    -Dmultilib=false \
    -Dtests=false \
    -Dpicocrt=false \
    -Ddebug=false \
    $(PICOLIBC_SOURCE_DIR)

build-picolibc: config-picolibc
	cd $(PICOLIBC_BUILD_DIR) && ninja install

clean-picolibc:
	@rm -rf $(PICOLIBC_BUILD_DIR) $(PICOLIBC_INSTALL_DIR)

