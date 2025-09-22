#line 1 "C:/Users/souza/OneDrive/Documentos/PicMusics/PicMusics.c"
#line 1 "c:/users/souza/onedrive/documentos/picmusics/notas.h"
#line 1 "c:/users/souza/onedrive/documentos/picmusics/melodias.h"
#line 6 "c:/users/souza/onedrive/documentos/picmusics/melodias.h"
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
#line 73 "c:/users/souza/onedrive/documentos/picmusics/melodias.h"
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
#line 102 "c:/users/souza/onedrive/documentos/picmusics/melodias.h"
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  466 ,  320 ,  523 ,  320 ,
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  349 ,  320 ,  370 ,  320 ,
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  466 ,  320 ,  523 ,  320 ,
 392 ,  320 ,  0 ,  160 ,  392 ,  160 + 320 ,  349 ,  320 ,  370 ,  320 ,
 392 ,  640 ,  0 ,  1280 
};

int qtdNotasMissao = sizeof(missao) / sizeof(missao[0]) / 2;
#line 116 "c:/users/souza/onedrive/documentos/picmusics/melodias.h"
int tfc[]={


 494 ,  80 ,  440 ,  80 ,  494 ,  160 ,  330 ,  320 + 320 ,  0 ,  160 ,
 523 ,  80 ,  494 ,  80 ,  523 ,  160 ,  494 ,  160 ,  440 ,  320 + 320 ,  0 ,  160 ,
 523 ,  80 ,  494 ,  80 ,  523 ,  320 ,  330 ,  320 + 320 ,  0 ,  160 ,
 440 ,  80 ,  392 ,  80 ,  440 ,  160 ,  392 ,  160 ,  370 ,  160 ,  440 ,  160 ,
 392 ,  320 ,  0 ,  160 ,

 494 ,  80 ,  440 ,  80 ,  494 ,  160 ,  330 ,  320 + 320 ,  0 ,  160 ,
 523 ,  80 ,  494 ,  80 ,  523 ,  160 ,  494 ,  160 ,  440 ,  320 + 320 ,  0 ,  160 ,
 523 ,  80 ,  494 ,  80 ,  523 ,  320 ,  330 ,  320 + 320 ,  0 ,  160 ,
 440 ,  80 ,  392 ,  80 ,  440 ,  160 ,  392 ,  160 ,  370 ,  160 ,  440 ,  160 ,
#line 147 "c:/users/souza/onedrive/documentos/picmusics/melodias.h"
 392 ,  320 + 160 ,  370 ,  80 ,  392 ,  80 ,  440 ,  320 + 160 ,  392 ,  80 ,  440 ,  80 ,
 494 ,  160 ,  440 ,  160 ,  392 ,  160 ,  370 ,  160 ,  330 ,  320 ,  523 ,  320 ,
 494 ,  640 ,  494 ,  160 ,  523 ,  320 ,  494 ,  80 ,  440 ,  80 ,  494 ,  1280 
};

int qtdNotasTfc = sizeof(tfc) / sizeof(tfc[0]) / 2;
#line 29 "C:/Users/souza/OneDrive/Documentos/PicMusics/PicMusics.c"
sbit LED_VERMELHO at RC0_bit;
sbit LED_VERDE at RC1_bit;
sbit LED_AZUL at RC2_bit;
sbit LED_VERMELHO_Direction at TRISC0_bit;
sbit LED_VERDE_Direction at TRISC1_bit;
sbit LED_AZUL_Direction at TRISC2_bit;


sbit IR_SENSOR at RA2_bit;
sbit IR_SENSOR_Direction at TRISA2_bit;

void ioPortsInit()
{
 ADCON1 = 0x0F;

 LED_VERMELHO_Direction = 0;
 LED_VERDE_Direction = 0;
 LED_AZUL_Direction = 0;

 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 0;

 IR_SENSOR_Direction = 1;
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

 while(IR_SENSOR == 1)
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
 }

}

void tocaCop()
{
 int nota = 0;
 int duracao = 0;
 int ritmo = 3;
 int ralenta = 2;



 for(nota = 0; nota < qtdNotasCop*2; nota += 2){
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
 }

 myDelayMs(250);
}

void tocaMissao()
{
 int nota = 0;
 int duracao = 0;
 int ritmo = 2;
 int ralenta = 1;

 for(nota = 0; nota < qtdNotasMissao*2; nota += 2){
 duracao = (missao[nota + 1]*ralenta) / ritmo;

 if(missao[nota] !=  0 )
 {
 Sound_Play(missao[nota], duracao);
 piscaLedsMs(duracao);
 }
 else
 {
 DoNotPiscaLedsMs(duracao*2);
 }
 }

 myDelayMs(250);
}

void tocaTfc()
{
 int nota = 0;
 int duracao = 0;
 int ritmo = 3;
 int ralenta = 2;



 for(nota = 0; nota < qtdNotasTfc*2; nota += 2){
 duracao = (tfc[nota + 1]*ralenta) / ritmo;

 if(tfc[nota] !=  0 )
 {
 Sound_Play(tfc[nota], duracao);
 piscaLedsMs(duracao);
 }
 else
 {
 DoNotPiscaLedsMs(duracao*2);
 }
 }

 myDelayMs(250);
}

void main() {

 int contador = 0;

 ioPortsInit();

 myDelayMs(250);


 while (1){
 if(IR_SENSOR == 0)
 {

 if(contador == 0)
 {
 tocaCop();
 contador = 1;
 }
 else if(contador == 1)
 {
 tocaMissao();
 contador = 2;
 }
 else if(contador == 2)
 {
 tocaTfc();
 contador = 0;
 }

 }
 else
 {
 giraLeds();
 }

 }
}
