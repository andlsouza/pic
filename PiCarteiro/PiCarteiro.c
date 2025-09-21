/*
 * Project name:
     PiCarteiro (Letter delivery notification program)

 * Copyright:
     (c) KitsPiC, 2025.

 * Revision History:
     v1.0:
       - initial release (ALS);

 * Description:
     When the postman delivers a letter, the sensor detects it and
     the notification led is turned ON indicating that a letter arrived.
     Just press the SWITCH to reset the notification led.

 * Test configuration:
     MCU:             PIC18F4620
     Dev.Board:       KP2840
                      www.kitspic.com.br
     Oscillator:      20.0000 MHz Crystal
     Ext. Modules:    None.
     SW:              mikroC PRO for PIC
 */

sbit NOTIFICATION_LED at RE0_bit;               //Led para notificação conectado em RE0
sbit NOTIFICATION_LED_Direction at TRISE0_bit;  //Controlador de direção da porta RE0
sbit IR_SENSOR at RE1_bit;                      //Sensor IR conectado em RE1
sbit IR_SENSOR_Direction at TRISE1_bit;         //Controlador de direção da porta RE1
sbit RESET_SWITCH at RE2_bit;                   //Switch conectado em RE2
sbit RESET_SWITCH_Direction at TRISE2_bit;      //Controlador de direção da porta RE2

void ioPortsInit()
{
 ADCON1 = 0x0F;                  //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
 NOTIFICATION_LED_Direction = 0; //Configurando porta RD1 como saída digital.
 NOTIFICATION_LED = 0;           //Turn OFF LED
 IR_SENSOR_Direction = 1;        //Entrada digital
 RESET_SWITCH_Direction = 1;     //Entrada digital
}

void main() {

     ioPortsInit();  //init ports

     // Endless loop:
     while (1){
      if(IR_SENSOR == 0) //sensor detectou algo na frente...
         {
          NOTIFICATION_LED = 1;           //Turn ON LED
          Delay_ms(250);
         }
      if(RESET_SWITCH == 1) //switch foi pressionado...
         {
          NOTIFICATION_LED = 0;           //Turn OFF LED
          Delay_ms(250);
         }
     }
}