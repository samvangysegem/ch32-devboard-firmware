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
  // TODO: Figure out what this configures
  li t0, 0x1f
  csrw 0xbc0, t0

  // Set intsyscr (0x804): enable hardware stack and nested interrupts
  // Value 0x0b = basic interrupt mode with hardware stack
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

  // Register all global C++ destructors to be called at program exit
  // Call all global C++ constructors
  la a0,__libc_fini_array
  call atexit
  call __libc_init_array

  // Call main
  la t0, main
  csrw mepc, t0
  mret
