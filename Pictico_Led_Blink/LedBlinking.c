/*
 * Project name:
     LED_Blinking (Simple 'Hello World' project)
     
 * Copyright:
     (c) KitsPiC, 2017.
     
 * Revision History:
     v1.0:
       - initial release (ALS);
       
 * Description:
     This is a simple 'Hello World' project. It turns on/off LEDs connected to
     PORTA, PORTB, PORTC, PORTD and PORTE.
      
 * Test configuration:
     MCU:             PIC18F2550
     Dev.Board:       PICTICO
                      www.kitspic.com.br
     Oscillator:      20MHz Crystal on board (48Mhz project configuration frequency)
     Ext. Modules:    None.
     SW:              mikroC PRO for PIC
 */

void main() {

  TRISA = 0;           // set direction to be output
  TRISB = 0;           // set direction to be output
  TRISC = 0;           // set direction to be output

  do {
    LATA = 0x00;       // Turn OFF LEDs on PORTA
    LATB = 0x00;       // Turn OFF LEDs on PORTB
    LATC = 0x00;       // Turn OFF LEDs on PORTC

    Delay_ms(1000);    // 1 second delay

    LATA = 0xFF;       // Turn ON LEDs on PORTA
    LATB = 0xFF;       // Turn ON LEDs on PORTB
    LATC = 0xFF;       // Turn ON LEDs on PORTC

    Delay_ms(1000);    // 1 second delay
    
  } while(1);          // Endless loop
}