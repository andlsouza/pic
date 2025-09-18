#line 1 "C:/Users/souza/Documents/PicMorse/PicMorse.c"
#line 1 "c:/users/souza/documents/picmorse/notas.h"
#line 1 "c:/users/souza/documents/picmorse/melodias.h"
#line 13 "c:/users/souza/documents/picmorse/melodias.h"
int sos[]={
 587 ,  80 ,
 0 ,  40 ,
 587 ,  80 ,
 0 ,  40 ,
 587 ,  80 ,

 0 ,  80 ,

 587 ,  160 ,
 0 ,  40 ,
 587 ,  160 ,
 0 ,  40 ,
 587 ,  160 ,

 0 ,  80 ,

 587 ,  80 ,
 0 ,  40 ,
 587 ,  80 ,
 0 ,  40 ,
 587 ,  80 ,

};

int qtdNotasSOS = sizeof(sos) / sizeof(sos[0]) / 2;
#line 28 "C:/Users/souza/Documents/PicMorse/PicMorse.c"
sbit LED_VERMELHO at RD1_bit;
sbit LED_VERMELHO_Direction at TRISD1_bit;

void ioPortsInit()
{
 ADCON1 = 0x0F;
 LED_VERMELHO_Direction = 0;
 LED_VERMELHO = 0;
 Sound_Init(&PORTC, 1);
}

void myDelayMs(int ms)
{
 int i = 0;
 for(i = 0; i <= ms; i++)
 {
 Delay_ms(1);
 }
}

void piscaLedsMs(int ms)
{
 int meio = 0;
 meio = ms/2;

 LED_VERMELHO = 1;
 myDelayMs(meio);

 LED_VERMELHO = 0;
 myDelayMs(meio);
}

void tocaSOS()
{
 int nota = 0;
 int duracao = 0;
 int ritmo = 1;
 int ralenta = 1;

 for(nota = 0; nota < qtdNotasSOS*2; nota += 2){
 duracao = (sos[nota + 1]*ralenta) / ritmo;
 Sound_Play(sos[nota], duracao);
 piscaLedsMs(duracao);
 }

 myDelayMs(500);


}

void main() {

 ioPortsInit();


 while (1){
 tocaSOS();
 }
}
