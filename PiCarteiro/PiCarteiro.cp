#line 1 "C:/Users/souza/OneDrive/Documentos/PiCarteiro/PiCarteiro.c"
#line 26 "C:/Users/souza/OneDrive/Documentos/PiCarteiro/PiCarteiro.c"
sbit NOTIFICATION_LED at RE0_bit;
sbit NOTIFICATION_LED_Direction at TRISE0_bit;
sbit IR_SENSOR at RE1_bit;
sbit IR_SENSOR_Direction at TRISE1_bit;
sbit RESET_SWITCH at RE2_bit;
sbit RESET_SWITCH_Direction at TRISE2_bit;

void ioPortsInit()
{
 ADCON1 = 0x0F;
 NOTIFICATION_LED_Direction = 0;
 NOTIFICATION_LED = 0;
 IR_SENSOR_Direction = 1;
 RESET_SWITCH_Direction = 1;
}

void main() {

 ioPortsInit();


 while (1){
 if(IR_SENSOR == 0)
 {
 NOTIFICATION_LED = 1;
 Delay_ms(250);
 }
 if(RESET_SWITCH == 1)
 {
 NOTIFICATION_LED = 0;
 Delay_ms(250);
 }
 }
}
