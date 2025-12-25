/* Linker script for CH32V30x series microcontrollers
 * Memory layout:
 *   FLASH:     0x08000000 (128KB)
 *   SYS_FLASH: 0x1FFF8000 (28KB)
 *   SRAM:      0x20000000 (32KB)
 *
 * Optimized for LLVM/LLD toolchain with picolibc and libcxx
 * Single-threaded bare-metal, no exceptions
 */

/* Stack configuration */
__stack_size = 0x1000; /* 4KB */

/* Memory segments */
MEMORY
{
  FLASH     (rx)  : ORIGIN = 0x08000000, LENGTH = 128K
  SYS_FLASH (rx)  : ORIGIN = 0x1FFF8000, LENGTH = 28K
  SRAM      (rwx) : ORIGIN = 0x20000000, LENGTH = 32K
}

/* Entry point */
ENTRY(_start)

/* Section definitions */
SECTIONS
{
  /* Startup code - contains _start entry point */
  .init : ALIGN(4)
  {
    KEEP(*(SORT_NONE(.init)))
    . = ALIGN(4);
  } > FLASH

  /* PFIC interrupt vector table */
  /* Must be 64-byte aligned per RISC-V MTVEC spec (vector mode) */
  .vector : ALIGN(64)
  {
    PROVIDE(_svector = .);
    KEEP(*(.vector))
    . = ALIGN(64);
  } > FLASH

  /* Program code */
  .text : ALIGN(4)
  {
    *(.text.unlikely .text.unlikely.*)
    *(.text.startup .text.startup.*)
    *(.text .text.*)
    *(.gnu.linkonce.t.*)
    . = ALIGN(4);
  } > FLASH

  /* Read-only data */
  .rodata : ALIGN(4)
  {
    *(.rodata .rodata.*)
    *(.gnu.linkonce.r.*)
    . = ALIGN(4);
  } > FLASH

  /* Finalization code - contains _fini function */
  .fini : ALIGN(4)
  {
    KEEP(*(SORT_NONE(.fini)))
    . = ALIGN(4);
  } > FLASH

  PROVIDE(_etext = .);

  /* Pre-initialization function pointers - called before constructors */
  .preinit_array : ALIGN(4)
  {
    PROVIDE_HIDDEN(__preinit_array_start = .);
    KEEP(*(.preinit_array))
    PROVIDE_HIDDEN(__preinit_array_end = .);
  } > FLASH

  /* Initialization function pointers - C++ constructors and C initializers */
  .init_array : ALIGN(4)
  {
    PROVIDE_HIDDEN(__init_array_start = .);
    KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
    KEEP(*(.init_array EXCLUDE_FILE(*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o) .ctors))
    PROVIDE_HIDDEN(__init_array_end = .);
  } > FLASH

  /* Finalization function pointers - C++ destructors and C finalizers */
  .fini_array : ALIGN(4)
  {
    PROVIDE_HIDDEN(__fini_array_start = .);
    KEEP(*(SORT_BY_INIT_PRIORITY(.fini_array.*) SORT_BY_INIT_PRIORITY(.dtors.*)))
    KEEP(*(.fini_array EXCLUDE_FILE(*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o) .dtors))
    PROVIDE_HIDDEN(__fini_array_end = .);
  } > FLASH

  /* Load address of .data section in FLASH */
  PROVIDE(_sidata = LOADADDR(.data));

  /* Initialized data - copied from FLASH to SRAM at startup */
  .data : ALIGN(8)
  {
    PROVIDE(_sdata = .);
    *(.data .data.*)
    *(.gnu.linkonce.d.*)
    *(.got .got.*)
    /* Small data at end for GP-relative addressing (±2KB from GP) */
    . = ALIGN(8);
    PROVIDE(__global_pointer$ = . + 0x800);
    *(.sdata .sdata.* .sdata2 .sdata2.*)
    *(.gnu.linkonce.s.*)
    . = ALIGN(8);
    PROVIDE(_edata = .);
  } > SRAM AT > FLASH

  PROVIDE(_data_size = _edata - _sdata);

  /* Uninitialized data - zeroed at startup */
  .bss (NOLOAD) : ALIGN(4)
  {
    PROVIDE(_sbss = .);
    /* Small bss at start for GP-relative addressing */
    *(.sbss .sbss.* .scommon)
    *(.gnu.linkonce.sb.*)
    *(.bss .bss.*)
    *(.gnu.linkonce.b.*)
    *(COMMON)
    . = ALIGN(4);
    PROVIDE(_ebss = .);
  } > SRAM

  PROVIDE(_bss_size = _ebss - _sbss);

  /* Heap region - grows upward from end of .bss */
  PROVIDE(end = .);
  PROVIDE(_end = .);
  PROVIDE(__heap_start = .);

  /* Stack region - reserved at top of SRAM, grows downward */
  .stack ORIGIN(SRAM) + LENGTH(SRAM) - __stack_size : ALIGN(4)
  {
    PROVIDE(__heap_end = .);
    . = . + __stack_size;
    . = ALIGN(4);
    PROVIDE(_estack = .);
  } > SRAM

  /* Discard unnecessary sections */
  /DISCARD/ :
  {
    *(.note*)
    *(.comment)
    *(.eh_frame*)
    *(.ARM.exidx*)
    *(.ARM.extab*)
  }
}
