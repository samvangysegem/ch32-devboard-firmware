/*******************************************************************************
 * CH32V30x Interrupt Handlers
 * Default handler, weak aliases, and vector table
 ******************************************************************************/

// Default interrupt handler
void Default_Handler(void) {
    for(;;) {
        __asm__ volatile("nop");
    }
}

// Core exception handlers
__attribute__((weak, alias("Default_Handler"))) void NMI_Handler(void);
__attribute__((weak, alias("Default_Handler"))) void HardFault_Handler();
__attribute__((weak, alias("Default_Handler"))) void Ecall_M_Mode_Handler();
__attribute__((weak, alias("Default_Handler"))) void Ecall_U_Mode_Handler();
__attribute__((weak, alias("Default_Handler"))) void Break_Point_Handler();
__attribute__((weak, alias("Default_Handler"))) void SysTick_Handler();
__attribute__((weak, alias("Default_Handler"))) void SW_Handler();

// External peripheral interrupt handlers
__attribute__((weak, alias("Default_Handler"))) void WWDG_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void PVD_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TAMPER_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void RTC_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void FLASH_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void RCC_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void EXTI0_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void EXTI1_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void EXTI2_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void EXTI3_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void EXTI4_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA1_Channel1_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA1_Channel2_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA1_Channel3_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA1_Channel4_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA1_Channel5_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA1_Channel6_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA1_Channel7_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void ADC1_2_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void USB_HP_CAN1_TX_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void USB_LP_CAN1_RX0_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void CAN1_RX1_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void CAN1_SCE_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void EXTI9_5_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM1_BRK_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM1_UP_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM1_TRG_COM_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM1_CC_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM2_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM3_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM4_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void I2C1_EV_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void I2C1_ER_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void I2C2_EV_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void I2C2_ER_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void SPI1_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void SPI2_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void USART1_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void USART2_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void USART3_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void EXTI15_10_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void RTCAlarm_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void USBWakeUp_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM8_BRK_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM8_UP_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM8_TRG_COM_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM8_CC_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void RNG_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void SDIO_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM5_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void SPI3_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void UART4_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void UART5_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM6_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM7_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel1_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel2_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel3_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel4_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel5_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void ETH_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void ETH_WKUP_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void CAN2_TX_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void CAN2_RX0_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void CAN2_RX1_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void CAN2_SCE_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void USBFS_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void USBHSWakeup_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void USBHS_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DVP_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void UART6_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void UART7_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void UART8_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM9_BRK_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM9_UP_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM9_TRG_COM_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM9_CC_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM10_BRK_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM10_UP_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM10_TRG_COM_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void TIM10_CC_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel6_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel7_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel8_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel9_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel10_IRQHandler();
__attribute__((weak, alias("Default_Handler"))) void DMA2_Channel11_IRQHandler();

// PFIC interrupt vector table - placed in .vector section
typedef void(*InterruptHandler)();

__attribute__((section(".vector"), used))
const InterruptHandler vector_table[104] = {
  0,                           // 0: Entry point (reset)
  0,                           // 1: Reserved
  NMI_Handler,                 // 2: NMI
  HardFault_Handler,           // 3: Hard Fault
  0,                           // 4: Reserved
  Ecall_M_Mode_Handler,        // 5: Ecall M Mode
  0,                           // 6: Reserved
  0,                           // 7: Reserved
  Ecall_U_Mode_Handler,        // 8: Ecall U Mode
  Break_Point_Handler,         // 9: Break Point
  0,                           // 10: Reserved
  0,                           // 11: Reserved
  SysTick_Handler,             // 12: SysTick
  0,                           // 13: Reserved
  SW_Handler,                  // 14: Software
  0,                           // 15: Reserved

  // External interrupts (IRQ 0+)
  WWDG_IRQHandler,             // 16: Window Watchdog
  PVD_IRQHandler,              // 17: PVD
  TAMPER_IRQHandler,           // 18: Tamper
  RTC_IRQHandler,              // 19: RTC
  FLASH_IRQHandler,            // 20: Flash
  RCC_IRQHandler,              // 21: RCC
  EXTI0_IRQHandler,            // 22: EXTI0
  EXTI1_IRQHandler,            // 23: EXTI1
  EXTI2_IRQHandler,            // 24: EXTI2
  EXTI3_IRQHandler,            // 25: EXTI3
  EXTI4_IRQHandler,            // 26: EXTI4
  DMA1_Channel1_IRQHandler,    // 27: DMA1 Channel 1
  DMA1_Channel2_IRQHandler,    // 28: DMA1 Channel 2
  DMA1_Channel3_IRQHandler,    // 29: DMA1 Channel 3
  DMA1_Channel4_IRQHandler,    // 30: DMA1 Channel 4
  DMA1_Channel5_IRQHandler,    // 31: DMA1 Channel 5
  DMA1_Channel6_IRQHandler,    // 32: DMA1 Channel 6
  DMA1_Channel7_IRQHandler,    // 33: DMA1 Channel 7
  ADC1_2_IRQHandler,           // 34: ADC1_2
  USB_HP_CAN1_TX_IRQHandler,   // 35: USB HP CAN1 TX
  USB_LP_CAN1_RX0_IRQHandler,  // 36: USB LP CAN1 RX0
  CAN1_RX1_IRQHandler,         // 37: CAN1 RX1
  CAN1_SCE_IRQHandler,         // 38: CAN1 SCE
  EXTI9_5_IRQHandler,          // 39: EXTI9_5
  TIM1_BRK_IRQHandler,         // 40: TIM1 Break
  TIM1_UP_IRQHandler,          // 41: TIM1 Update
  TIM1_TRG_COM_IRQHandler,     // 42: TIM1 Trigger
  TIM1_CC_IRQHandler,          // 43: TIM1 Capture Compare
  TIM2_IRQHandler,             // 44: TIM2
  TIM3_IRQHandler,             // 45: TIM3
  TIM4_IRQHandler,             // 46: TIM4
  I2C1_EV_IRQHandler,          // 47: I2C1 Event
  I2C1_ER_IRQHandler,          // 48: I2C1 Error
  I2C2_EV_IRQHandler,          // 49: I2C2 Event
  I2C2_ER_IRQHandler,          // 50: I2C2 Error
  SPI1_IRQHandler,             // 51: SPI1
  SPI2_IRQHandler,             // 52: SPI2
  USART1_IRQHandler,           // 53: USART1
  USART2_IRQHandler,           // 54: USART2
  USART3_IRQHandler,           // 55: USART3
  EXTI15_10_IRQHandler,        // 56: EXTI15_10
  RTCAlarm_IRQHandler,         // 57: RTC Alarm
  USBWakeUp_IRQHandler,        // 58: USB Wakeup
  TIM8_BRK_IRQHandler,         // 59: TIM8 Break
  TIM8_UP_IRQHandler,          // 60: TIM8 Update
  TIM8_TRG_COM_IRQHandler,     // 61: TIM8 Trigger
  TIM8_CC_IRQHandler,          // 62: TIM8 Capture Compare
  RNG_IRQHandler,              // 63: RNG
  0,                           // 64: Reserved (was FSMC in WCH code)
  SDIO_IRQHandler,             // 65: SDIO
  TIM5_IRQHandler,             // 66: TIM5
  SPI3_IRQHandler,             // 67: SPI3
  UART4_IRQHandler,            // 68: UART4
  UART5_IRQHandler,            // 69: UART5
  TIM6_IRQHandler,             // 70: TIM6
  TIM7_IRQHandler,             // 71: TIM7
  DMA2_Channel1_IRQHandler,    // 72: DMA2 Channel 1
  DMA2_Channel2_IRQHandler,    // 73: DMA2 Channel 2
  DMA2_Channel3_IRQHandler,    // 74: DMA2 Channel 3
  DMA2_Channel4_IRQHandler,    // 75: DMA2 Channel 4
  DMA2_Channel5_IRQHandler,    // 76: DMA2 Channel 5
  ETH_IRQHandler,              // 77: Ethernet
  ETH_WKUP_IRQHandler,         // 78: Ethernet Wakeup
  CAN2_TX_IRQHandler,          // 79: CAN2 TX
  CAN2_RX0_IRQHandler,         // 80: CAN2 RX0
  CAN2_RX1_IRQHandler,         // 81: CAN2 RX1
  CAN2_SCE_IRQHandler,         // 82: CAN2 SCE
  USBFS_IRQHandler,            // 83: USBFS
  USBHSWakeup_IRQHandler,      // 84: USBHS Wakeup
  USBHS_IRQHandler,            // 85: USBHS
  DVP_IRQHandler,              // 86: DVP
  UART6_IRQHandler,            // 87: UART6
  UART7_IRQHandler,            // 88: UART7
  UART8_IRQHandler,            // 89: UART8
  TIM9_BRK_IRQHandler,         // 90: TIM9 Break
  TIM9_UP_IRQHandler,          // 91: TIM9 Update
  TIM9_TRG_COM_IRQHandler,     // 92: TIM9 Trigger
  TIM9_CC_IRQHandler,          // 93: TIM9 Capture Compare
  TIM10_BRK_IRQHandler,        // 94: TIM10 Break
  TIM10_UP_IRQHandler,         // 95: TIM10 Update
  TIM10_TRG_COM_IRQHandler,    // 96: TIM10 Trigger
  TIM10_CC_IRQHandler,         // 97: TIM10 Capture Compare
  DMA2_Channel6_IRQHandler,    // 98: DMA2 Channel 6
  DMA2_Channel7_IRQHandler,    // 99: DMA2 Channel 7
  DMA2_Channel8_IRQHandler,    // 100: DMA2 Channel 8
  DMA2_Channel9_IRQHandler,    // 101: DMA2 Channel 9
  DMA2_Channel10_IRQHandler,   // 102: DMA2 Channel 10
  DMA2_Channel11_IRQHandler,   // 103: DMA2 Channel 11
};
