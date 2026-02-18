/*******************************************************************************
 * CH32V30x Startup Code (Assembly Version)
 * Entry point (_start) and initialization routines
 ******************************************************************************/

  .section .init, "ax"
  .global _start
  .type _start, @function
_start:
  // Initialize global pointer (RISC-V ABI optimization)
  .option push
  .option norelax
  la gp, __global_pointer$
  .option pop

  // Initialize stack pointer
  la sp, _estack

  // Initialize .data section (copy from FLASH to RAM)
  la a0, _sdata           // Destination: start of .data in RAM
  la a1, _sidata          // Source: .data initial values in FLASH
  la a2, _data_size       // Size provided by linker
  beqz a2, 2f             // Skip if size is zero
  call memcpy             // Call memcpy(dest, src, size)

2:
  // Initialize .bss section (zero it out)
  la a0, _sbss            // Destination: start of .bss
  li a1, 0                // Value: 0
  la a2, _bss_size        // Size provided by linker
  beqz a2, 3f             // Skip if size is zero
  call memset             // Call memset(dest, 0, size)

3:
  // Configure RISC-V CSRs (Control Status Registers)
  // ref. QingKeV4 Processor Manual, 8.1
  // [corecfgr]
  //     [1] - [Icdisable] (1) Disable command cache function
  li t0, 0x1f
  csrw 0xbc0, t0

  // ref. QingKeV4 Processor Manual, 3.2 & 8.1
  // [intsyscr]
  //   [3:2] - [PMTCFG] (0b10) 4 levels of nesting, with 2 preemption bits
  //     [1] - [INESTEN] (1) Interrupt nesting function enabled
  //     [0] - [HWSTKEN] (1) HPE function enabled
  li t0, 0x0b
  csrw 0x804, t0

  // ref. QingKeV4 Processor Manual, 1.3 & 8.1
  // [mstatus]
  // [14:13] - Floating point unit status
  //           (00) Disabled
  // [12:11] - [MPP] Privilege mode
  //           (11) Machine mode
  //     [7] - [MPIE] (1) Interrupt enable state before entering interrupt
  //     [3] - [MIE] (1) Machine mode interrupt enable
  li t0, 0x1888
  csrw mstatus, t0

  // ref. QingKeV4 Processor Manual, 2.2
  // [mtvec]
  // [31:2] - Base address of vector table
  //    [1] - 1: Enable vector table mode for interruptions/exceptions
  //          Handler address: mtvec[31:2] + interrupt_number * 4
  //    [0] - 1: Absolute address of handler is stored in vector table
  la t0, _svector
  ori t0, t0, 3
  csrw mtvec, t0

  // TODO: System initialization call?

  // Register all global C++ destructors to be called at program exit
  // Call all global C++ constructors
  la a0,__libc_fini_array
  call atexit
  call __libc_init_array

  // ref. QingKeV4 Processor Manual, 2.4
  // ```
  // When calling mret:
  // - Execution resumes at address stored in `mepc`
  // - MIE is restored to MPIE
  // - MPP is used to restore privileged mode
  // ```
  // Call main via mret to activate mstatus configuration (line 54)
  // and enable interrupt handling
  la t0, main
  csrw mepc, t0
  mret
