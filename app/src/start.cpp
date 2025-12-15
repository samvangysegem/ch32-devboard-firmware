
extern "C" int main();

extern "C" void _start() {
    // TODO: Initialize .data section (copy from FLASH to SRAM)
    // TODO: Zero out .bss section

    main();
}