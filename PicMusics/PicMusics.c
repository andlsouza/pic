/*
 * Project name:
     PicMusic (Music generator for Pictico board with PIC18F2550)

 * Copyright:
     (c) KitsPiC, 2025.

 * Revision History:
     v1.0:
       - initial release (ALS);
     v2.0:
       - otimizações (ALS);

 * Description:
     This is a simple music generator for Pictico!
     Music is played (and changed) when IR sensor is activated.

 * Test configuration:
     MCU:             PIC18F2550
     Dev.Board:       Pictico
                      www.kitspic.com.br
     Oscillator:      20MHz Crystal on board (48Mhz project configuration frequency)
     Ext. Modules:    None.
     SW:              mikroC PRO for PIC
 */

#include "notas.h"
#include "melodias.h"

//Led declarations:
sbit LED_VERMELHO at RC0_bit;
sbit LED_VERDE at RC1_bit;
sbit LED_AZUL at RC2_bit;
sbit LED_VERMELHO_Direction at TRISC0_bit;
sbit LED_VERDE_Direction at TRISC1_bit;
sbit LED_AZUL_Direction at TRISC2_bit;

//IR Sensor declarations:
sbit IR_SENSOR at RA2_bit;                 //Sensor IR conectado em RA2
sbit IR_SENSOR_Direction at TRISA2_bit;    //Controlador de direção da porta RA2

void ioPortsInit()
{
 ADCON1 = 0x0F;              //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
 
 LED_VERMELHO_Direction = 0; //configurando porta RC0 como saída digital.
 LED_VERDE_Direction = 0;    //configurando porta RC1 como saída digital.
 LED_AZUL_Direction = 0;     //configurando porta RC2 como saída digital.
 // Turn OFF LEDs:
 LED_VERMELHO = 0;
 LED_VERDE = 0;
 LED_AZUL = 0;
 
 IR_SENSOR_Direction = 1;    //Configurando porta RA2 como entrada digital
 Sound_Init(&PORTA, 0);      //Buzzer conectado ao pino RA0
}

//my ms delay funtion:
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
  // Turn ON all LEDs:
  LED_VERMELHO = 1;
  LED_VERDE = 1;
  LED_AZUL = 1;
  myDelayMs(meio);
  // Turn OFF all LEDs:
  LED_VERMELHO = 0;
  LED_VERDE = 0;
  LED_AZUL = 0;
  myDelayMs(meio);
}

//just to spend the same time as piscaLedsMs but with leds off:
void DoNotPiscaLedsMs(int ms)
{
  int meio = 0;
  meio = ms/2;
  // Turn OFF all LEDs:
  LED_VERMELHO = 0;
  LED_VERDE = 0;
  LED_AZUL = 0;
  myDelayMs(meio);
  // Turn OFF all LEDs:
  LED_VERMELHO = 0;
  LED_VERDE = 0;
  LED_AZUL = 0;
  myDelayMs(meio);
}

void giraLeds()
{
  int gira = 0;

  while(IR_SENSOR == 1) //não detectou nada no sensor ir...
    {
      switch (gira) {
        case 0: 
          LED_VERMELHO = 0;
          LED_VERDE = 0;
          LED_AZUL = 0;
          gira++;
          break;
        case 1: //vermelho
          LED_VERMELHO = 1;
          LED_VERDE = 0;
          LED_AZUL = 0;
          gira++;
          break;
        case 2: //amarelo
          LED_VERMELHO = 1;
          LED_VERDE = 1;
          LED_AZUL = 0;
          gira++;
          break;
        case 3: //verde
          LED_VERMELHO = 0;
          LED_VERDE = 1;
          LED_AZUL = 0;
          gira++;
          break;
        case 4: //ciano
          LED_VERMELHO = 0;
          LED_VERDE = 1;
          LED_AZUL = 1;
          gira++;
          break;
        case 5: //azul
          LED_VERMELHO = 0;
          LED_VERDE = 0;
          LED_AZUL = 1;
          gira++;
          break;
        case 6: //roxo
          LED_VERMELHO = 1;
          LED_VERDE = 0;
          LED_AZUL = 1;
          gira = 1; //volta para o vermelho
          break;
        default:
          gira = 0; //apaga tudo
          break;
      }
     myDelayMs(250); //aguarda um tempo de 250ms.
    }

}

void tocaCop()
{
  int nota = 0;
  int duracao = 0;
  int ritmo = 3; //1 = velocidade normal, 2 = velocidade 2x, 4 = velocidade 4x.
  int ralenta = 2; //velocidade / ralenta
  
  //velocidade aqui: 3/2 = 1.5

  for(nota = 0; nota < qtdNotasCop*2; nota += 2){
     duracao = (cop[nota + 1]*ralenta) / ritmo;
     if(cop[nota] != PAUSA)
        {
         Sound_Play(cop[nota], duracao);
         piscaLedsMs(duracao);
        }
        else //pausa...
           {
            DoNotPiscaLedsMs(duracao*2); //soundplay duration + piscaLeds duration
           }
    }

  myDelayMs(250); //aguarda um tempo de 250ms.
}

void tocaMissao()
{
  int nota = 0;
  int duracao = 0;
  int ritmo = 2; //1 = velocidade normal, 2 = velocidade 2x, 4 = velocidade 4x.
  int ralenta = 1; //velocidade / 1

  for(nota = 0; nota < qtdNotasMissao*2; nota += 2){
    duracao = (missao[nota + 1]*ralenta) / ritmo;

    if(missao[nota] != PAUSA)
      {
       Sound_Play(missao[nota], duracao);
       piscaLedsMs(duracao);
      }
      else //pausa...
        {
         DoNotPiscaLedsMs(duracao*2); //soundplay duration + piscaLeds duration
        }
    }
      
  myDelayMs(250); //aguarda um tempo de 250ms.
}

void tocaTfc()
{
  int nota = 0;
  int duracao = 0;
  int ritmo = 4; //1 = velocidade normal, 2 = velocidade 2x, 4 = velocidade 4x.
  int ralenta = 3; //velocidade / 1
  
  //velocidade aqui: 4/3 = 1.333

  for(nota = 0; nota < qtdNotasTfc*2; nota += 2){
    duracao = (tfc[nota + 1]*ralenta) / ritmo;

    if(tfc[nota] != PAUSA)
      {
       Sound_Play(tfc[nota], duracao);
       piscaLedsMs(duracao);
      }
      else //pausa...
        {
         DoNotPiscaLedsMs(duracao*2); //soundplay duration + piscaLeds duration
        }
    }

  myDelayMs(250); //aguarda um tempo de 250ms.
}

void main() {

     int contador = 0;

     ioPortsInit();  //init ports
     
     myDelayMs(250); //250ms delay to reprog if needed.

     // Endless loop:
     while (1){
      if(IR_SENSOR == 0) //sensor detectou algo na frente...
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
                 contador = 0; //on last melody, reset the counter
                }
                //other melodies...
         }
         else
           {
            giraLeds();
           }
         
     }
}