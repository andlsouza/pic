#line 1 "E:/PESSOAIS/PROJETOS/#software/Prog_Testes_PIC18F4620/KP2840_v1p0_Uart_Test_for_PIC18F4620/Uart_test.c"
#line 26 "E:/PESSOAIS/PROJETOS/#software/Prog_Testes_PIC18F4620/KP2840_v1p0_Uart_Test_for_PIC18F4620/Uart_test.c"
char uart_rd;

void main() {

 UART1_Init(115200);
 Delay_ms(100);

 UART1_Write_Text("Start");
 UART1_Write(10);
 UART1_Write(13);

 while (1) {
 if (UART1_Data_Ready()) {
 uart_rd = UART1_Read();
 UART1_Write(uart_rd);
 }
 }
}
