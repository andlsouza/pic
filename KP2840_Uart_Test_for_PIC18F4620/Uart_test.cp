#line 1 "C:/Users/souza/Documents/KP2840_v1p0_Prog_Testes_for_PIC18F4620/KP2840_v1p0_Uart_Test_for_PIC18F4620/Uart_test.c"
#line 29 "C:/Users/souza/Documents/KP2840_v1p0_Prog_Testes_for_PIC18F4620/KP2840_v1p0_Uart_Test_for_PIC18F4620/Uart_test.c"
char uart_rd;

void main() {

 TRISD = 0;
 LATD = 0x00;

 UART1_Init(115200);
 Delay_ms(100);

 UART1_Write_Text("Start");
 UART1_Write(10);
 UART1_Write(13);

 while (1) {
 if (UART1_Data_Ready()) {
 LATD = 0xFF;
 Delay_ms(50);
 uart_rd = UART1_Read();
 UART1_Write(uart_rd);
 LATD = 0x00;
 }
 }
}
