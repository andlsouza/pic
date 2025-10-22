#line 1 "C:/Users/souza/OneDrive/Documentos/PicBot/PicBot.c"
#line 1 "c:/users/souza/onedrive/documentos/picbot/notas.h"
#line 1 "c:/users/souza/onedrive/documentos/picbot/melodias.h"
#line 12 "c:/users/souza/onedrive/documentos/picbot/melodias.h"
int cop[]={

 659 ,  320 ,
 784 ,  160 + 80 ,
 659 ,  80 + 80 ,
 659 ,  80 ,
 880 ,  160 ,
 659 ,  160 ,
 294 ,  160 ,

 659 ,  320 ,
 988 ,  160 + 80 ,
 659 ,  80 + 80 ,
 659 ,  80 ,
 1047 ,  160 ,
 988 ,  160 ,
 784 ,  160 ,

 659 ,  160 ,
 988 ,  160 ,
 1319 ,  160 ,
 659 ,  80 ,
 294 ,  80 + 80 ,
 294 ,  80 ,
 494 ,  160 ,
 740 ,  160 ,
 659 ,  160 + 1280 ,


 659 ,  320 ,
 784 ,  160 + 80 ,
 659 ,  80 + 80 ,
 659 ,  80 ,
 880 ,  160 ,
 659 ,  160 ,
 294 ,  160 ,

 659 ,  320 ,
 988 ,  160 + 80 ,
 659 ,  80 + 80 ,
 659 ,  80 ,
 1047 ,  160 ,
 988 ,  160 ,
 784 ,  160 ,

 659 ,  160 ,
 988 ,  160 ,
 1319 ,  160 ,
 659 ,  80 ,
 294 ,  80 + 80 ,
 294 ,  80 ,
 494 ,  160 ,
 740 ,  160 ,
 659 ,  160 + 1280 


};

int qtdNotasCop = sizeof(cop) / sizeof(cop[0]) / 2;
#line 42 "C:/Users/souza/OneDrive/Documentos/PicBot/PicBot.c"
sbit LED_VERMELHO at RC0_bit;
sbit LED_VERDE at RC1_bit;
sbit LED_AZUL at RC2_bit;
sbit LED_VERMELHO_Direction at TRISC0_bit;
sbit LED_VERDE_Direction at TRISC1_bit;
sbit LED_AZUL_Direction at TRISC2_bit;


sbit SWITCH_1 at RB0_bit;
sbit SWITCH_1_Direction at TRISB0_bit;

int modo = 0;

void ioPortsInit()
{
 ADCON1 = 0x0F;

 LED_VERMELHO_Direction = 0;
 LED_VERDE_Direction = 0;
 LED_AZUL_Direction = 0;


 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 0;

 SWITCH_1_Direction = 1;

 Sound_Init(&PORTA, 0);
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
 LED_VERDE = 1;
 LED_AZUL = 1;
 myDelayMs(meio);

 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 0;
 myDelayMs(meio);
}


void DoNotPiscaLedsMs(int ms)
{
 int meio = 0;
 meio = ms/2;

 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 0;
 myDelayMs(meio);

 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 0;
 myDelayMs(meio);
}

void giraLeds()
{
 int gira = 0;

 while (modo == 8)
 {
 if(gira == 0)
 {
 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 0;
 gira = 1;
 }
 else if(gira == 1)
 {
 LED_VERMELHO = 1;
 LED_VERDE = 0;
 LED_AZUL = 0;
 gira = 2;
 }
 else if(gira == 2)
 {
 LED_VERMELHO = 1;
 LED_VERDE = 1;
 LED_AZUL = 0;
 gira = 3;
 }
 else if(gira == 3)
 {
 LED_VERMELHO = 0;
 LED_VERDE = 1;
 LED_AZUL = 0;
 gira = 4;
 }
 else if(gira == 4)
 {
 LED_VERMELHO = 0;
 LED_VERDE = 1;
 LED_AZUL = 1;
 gira = 5;
 }
 else if(gira == 5)
 {
 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 1;
 gira = 6;
 }
 else if(gira == 6)
 {
 LED_VERMELHO = 1;
 LED_VERDE = 0;
 LED_AZUL = 1;
 gira = 1;
 }
 myDelayMs(250);

 if(SWITCH_1 == 1)
 {
 modo = 9;
 myDelayMs(500);
 }
 }

}

void tocaCop()
{
 int nota = 0;
 int duracao = 0;
 int ritmo = 3;
 int ralenta = 2;



 while (modo == 9)
 {
 for(nota = 0; nota < qtdNotasCop*2; nota += 2)
 {
 duracao = (cop[nota + 1]*ralenta) / ritmo;
 if(cop[nota] !=  0 )
 {
 Sound_Play(cop[nota], duracao);
 piscaLedsMs(duracao);
 }
 else
 {
 DoNotPiscaLedsMs(duracao*2);
 }

 if(SWITCH_1 == 1)
 {
 modo = 0;
 myDelayMs(500);
 break;
 }

 }
 myDelayMs(250);
 }
}

void main() {

 ioPortsInit();


 while (1) {

 if(SWITCH_1 == 1)
 {
 if(modo <= 9)
 {
 modo++;
 }
 else
 {
 modo = 0;
 }
 myDelayMs(500);
 }


 if(modo == 0)
 {

 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 0;
 }
 else if(modo == 1)
 {

 LED_VERMELHO = 1;
 LED_VERDE = 0;
 LED_AZUL = 0;
 }
 else if(modo == 2)
 {

 LED_VERMELHO = 1;
 LED_VERDE = 1;
 LED_AZUL = 0;
 }
 else if(modo == 3)
 {

 LED_VERMELHO = 0;
 LED_VERDE = 1;
 LED_AZUL = 0;
 }
 else if(modo == 4)
 {

 LED_VERMELHO = 0;
 LED_VERDE = 1;
 LED_AZUL = 1;
 }
 else if(modo == 5)
 {

 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 1;
 }
 else if(modo == 6)
 {

 LED_VERMELHO = 1;
 LED_VERDE = 0;
 LED_AZUL = 1;
 }
 else if(modo == 7)
 {

 LED_VERMELHO = 1;
 LED_VERDE = 1;
 LED_AZUL = 1;
 }
 else if(modo == 8)
 {
 giraLeds();
 }
 else if(modo == 9)
 {
 tocaCop();
 }
 else
 {
 modo = 0;
 }

 }
}
