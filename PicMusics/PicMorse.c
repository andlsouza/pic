/*
 * Project name:
     PicMorse (Morse code for KP2840 board with PIC18F4620)

 * Copyright:
     (c) KitsPiC, 2025.

 * Revision History:
     v1.0:
       - initial release (ALS);
     v2.0:
       - pause noise fixed.
     v3.0:
       - ir sensor, new melodies, ports relocated.

 * Description:
     This is a simple SOS Morse code project.
     Pic sends a SOS message continuously to the buzzer and led.

 * Test configuration:
     MCU:             PIC18F4620
     Dev.Board:       KP2840
                      www.kitspic.com.br
     Oscillator:      20.0000 MHz Crystal
     Ext. Modules:    None.
     SW:              mikroC PRO for PIC
 */

#include "notas.h"
#include "melodias.h"

sbit LED_VERMELHO at RE0_bit;              //Led vermelho conectado em RE0
sbit LED_VERMELHO_Direction at TRISE0_bit; //Controlador de direção da porta RE0
sbit SENSOR_IR at RE1_bit;                 //Sensor IR conectado em RE1
sbit SENSOR_IR_Direction at TRISE1_bit;    //Controlador de direção da porta RE1

void ioPortsInit()
{
 ADCON1 = 0x0F;              //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
 LED_VERMELHO_Direction = 0; //Configurando porta RD1 como saída digital.
 LED_VERMELHO = 0;           //Turn OFF LED
 SENSOR_IR_Direction = 1;    //Entrada digital
 Sound_Init(&PORTC, 1);      //Buzzer conectado ao pino RC1
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
  // Turn ON LED:
  LED_VERMELHO = 1;
  myDelayMs(meio);
  // Turn OFF LED:
  LED_VERMELHO = 0;
  myDelayMs(meio);
}

//just to spend the same time as piscaLedsMs but with leds off:
void DoNotPiscaLedsMs(int ms)
{
  int meio = 0;
  meio = ms/2;
  // Turn ON LED:
  LED_VERMELHO = 0;
  myDelayMs(meio);
  // Turn OFF LED:
  LED_VERMELHO = 0;
  myDelayMs(meio);
}

void tocaSOS()
{
  int nota = 0;
  int duracao = 0;
  int ritmo = 1; //1 = velocidade normal, 2 = velocidade 2x, 4 = velocidade 4x.
  int ralenta = 1; //velocidade / 1

  for(nota = 0; nota < qtdNotasSOS*2; nota += 2){
     duracao = (sos[nota + 1]*ralenta) / ritmo;
     if(sos[nota] != PAUSA)
        {
         Sound_Play(sos[nota], duracao);
         piscaLedsMs(duracao); //fica muito lento (usar com ritmo 2x)
        }
        else //pausa...
           {
            DoNotPiscaLedsMs(duracao*2); //soundplay + led duration
           }
    }

  myDelayMs(500); //aguarda um tempo de 500ms.
}

void tocaCop()
{
  int nota = 0;
  int duracao = 0;
  int ritmo = 3; //1 = velocidade normal, 2 = velocidade 2x, 4 = velocidade 4x.
  int ralenta = 2; //velocidade / 1

  for(nota = 0; nota < qtdNotasCop*2; nota += 2){
     duracao = (cop[nota + 1]*ralenta) / ritmo;
     if(cop[nota] != PAUSA)
        {
         Sound_Play(cop[nota], duracao);
         piscaLedsMs(duracao); //fica muito lento (usar com ritmo 2x)
        }
        else //pausa...
           {
            DoNotPiscaLedsMs(duracao*2); //soundplay + led duration
           }
    }

  myDelayMs(250); //aguarda um tempo de 500ms.
}

void main() {

     ioPortsInit();  //init ports

     // Endless loop:
     while (1){
      if(SENSOR_IR == 0) //sensor detectou algo na frente...
         {
          tocaSOS();
         }
      //tocaCop();
     }
}