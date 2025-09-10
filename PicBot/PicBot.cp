#line 1 "C:/Users/souza/Documents/PicBot/PicBot.c"
#line 1 "c:/users/souza/documents/picbot/notas.h"
#line 1 "c:/users/souza/documents/picbot/melodias.h"



int missao[]={
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  466 ,  320 ,  523 ,  320 ,
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  349 ,  320 ,  370 ,  320 ,
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  466 ,  320 ,  523 ,  320 ,
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  349 ,  320 ,  370 ,  320 ,

 988 ,  160 ,  784 ,  160 ,  587 ,  1280 ,
 988 ,  160 ,  784 ,  160 ,  277 ,  1280 ,
 988 ,  160 ,  784 ,  160 ,  262 ,  1280 ,
 494 ,  160 ,  262 ,  160 ,  0 ,  1280 ,

 494 ,  160 ,  392 ,  160 ,  740 ,  1280 ,
 494 ,  160 ,  392 ,  160 ,  698 ,  1280 ,
 494 ,  160 ,  392 ,  160 ,  659 ,  1280 ,
 659 ,  160 ,  587 ,  160 ,  0 ,  1280 ,


 659 ,  160 ,  262 ,  160 ,  392 ,  1280 ,
 659 ,  160 ,  262 ,  160 ,  370 ,  1280 ,
 659 ,  160 ,  262 ,  160 ,  349 ,  1280 ,
 330 ,  160 ,  349 ,  160 ,  0 ,  1280 ,

 988 ,  160 ,  784 ,  160 ,  587 ,  1280 ,
 988 ,  160 ,  784 ,  160 ,  277 ,  1280 ,
 988 ,  160 ,  784 ,  160 ,  262 ,  1280 ,
 494 ,  160 ,  262 ,  160 ,  0 ,  1280 ,


 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  466 ,  320 ,  523 ,  320 ,
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  349 ,  320 ,  370 ,  320 ,
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  466 ,  320 ,  523 ,  320 ,
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  349 ,  320 ,  370 ,  320 ,
 392 ,  640 ,  0 ,  1280 
};

int qtdNotasMissao = sizeof(missao) / sizeof(missao[0]) / 2;
#line 38 "C:/Users/souza/Documents/PicBot/PicBot.c"
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

void piscaLeds()
{

 LED_VERMELHO = 1;
 LED_VERDE = 1;
 LED_AZUL = 1;
 Delay_ms(5);

 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 0;
 Delay_ms(5);
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

void tocaMissao()
{
 int nota = 0;
 int duracao = 0;
 int ritmo = 1;
 int ralenta = 1;

 while (modo == 9)
 {
 for(nota = 0; nota < qtdNotasMissao*2; nota += 2){
 duracao = (missao[nota + 1]*ralenta) / ritmo;
 Sound_Play(missao[nota], duracao);


 piscaLeds();

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
 tocaMissao();
 }
 else
 {
 modo = 0;
 }

 }
}
