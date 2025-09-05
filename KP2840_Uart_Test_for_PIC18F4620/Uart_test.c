/*
 * Project name:
     UART_Test (Simple UART Send/Receive project)

 * Copyright:
     (c) KitsPiC, 2017.

 * Revision History:
     v1.0:
       - initial release (ALS);

 * Description:
     This is a simple UART Send/Receive project. 
     The board receives data from UART and sends it back.
     Used baud rate = 115200 bps.

 * Test configuration:
     MCU:             PIC18F4620
     Dev.Board:       KP2840
                      www.kitspic.com.br
     Oscillator:      20.0000 MHz Crystal
     Ext. Modules:    None.
     SW:              mikroC PRO for PIC
 */

char uart_rd;

void main() {

  UART1_Init(115200);               // Initialize UART module at 115200 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("Start");
  UART1_Write(10);
  UART1_Write(13);

  while (1) {                     // Endless loop
    if (UART1_Data_Ready()) {     // If data is received,
      uart_rd = UART1_Read();     // read the received data,
      UART1_Write(uart_rd);       // and send data via UART
    }
  }
}