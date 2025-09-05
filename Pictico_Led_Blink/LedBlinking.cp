#line 1 "I:/PROJETOS/#0KITSPIC/#software/PICTICO_v1p0_Prog_Testes_for_PIC18F2550/LedBlinking.c"
#line 25 "I:/PROJETOS/#0KITSPIC/#software/PICTICO_v1p0_Prog_Testes_for_PIC18F2550/LedBlinking.c"
void main() {

 TRISA = 0;
 TRISB = 0;
 TRISC = 0;

 do {
 LATA = 0x00;
 LATB = 0x00;
 LATC = 0x00;

 Delay_ms(1000);

 LATA = 0xFF;
 LATB = 0xFF;
 LATC = 0xFF;

 Delay_ms(1000);

 } while(1);
}
