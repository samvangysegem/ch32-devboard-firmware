/* Linker script for CH32V3 series microcontrollers
 * Memory layout:
 *   FLASH:     0x08000000 (128KB)
 *   SYS_FLASH: 0x1FFF8000 (28KB)
 *   SRAM:      0x20000000 (32kB)
 */

/* Memory segments */
MEMORY
{
    FLASH     (rx)  : ORIGIN = 0x08000000, LENGTH = 128K
    SYS_FLASH (rx)  : ORIGIN = 0x1FFF8000, LENGTH = 28K
    SRAM      (rwx) : ORIGIN = 0x20000000, LENGTH = 32K
}

/* Stack size - adjust as needed */
_Min_Stack_Size = 0x2000; /* 8KB */
_estack = ORIGIN(SRAM) + LENGTH(SRAM);

/* Entry point */
ENTRY(_start)

/* Section definitions */
SECTIONS
{
    /* PFIC interrupt vector table at the start of FLASH */
    .vector_table : ALIGN(4)
    {
        KEEP(*(.vector_table))
        . = ALIGN(4);
    } > FLASH

    /* Program code and read-only data */
    .text : ALIGN(4)
    {
        *(.text)
        *(.text.*)
        
        /* C++ constructors/destructors */
        KEEP(*(.init))
        KEEP(*(.fini))
        
        . = ALIGN(4);
    } > FLASH

    /* Read-only data */
    .rodata : ALIGN(4)
    {
        *(.rodata)
        *(.rodata.*)
        . = ALIGN(4);
    } > FLASH

    /* Used by the startup code to initialize data */
    _sidata = LOADADDR(.data);

    /* Initialized data section - stored in FLASH, copied to SRAM at startup */
    .data : ALIGN(4)
    {
        _sdata = .;        /* Start of .data section in SRAM */
        *(.data)
        *(.data.*)
        . = ALIGN(4);
        _edata = .;        /* End of .data section in SRAM */
    } > SRAM AT > FLASH

    /* Uninitialized data section */
    .bss : ALIGN(4)
    {
        _sbss = .;         /* Start of .bss section */
        __bss_start__ = _sbss;
        *(.bss)
        *(.bss.*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;         /* End of .bss section */
        __bss_end__ = _ebss;
    } > SRAM

    /* Stack section - grows downward from _estack */
    .stack : ALIGN(8)
    {
        . = ALIGN(8);
        PROVIDE ( end = . );
        PROVIDE ( _end = . );
        . = . + _Min_Stack_Size;
        . = ALIGN(8);
    } > SRAM

    /* Remove information from the standard libraries */
    /DISCARD/ :
    {
        libc.a ( * )
        libm.a ( * )
        libgcc.a ( * )
    }
}

