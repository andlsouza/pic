/*
 * Project name:
     PicBot v6.0

 * Copyright:
     (c) KitsPiC, 2024.

 * Revision History:
     v1.0:
       - versão inicial (andlsouza@gmail.com);
     v2.0:
       - headers adicionados: notas.h e melodias.h (andlsouza@gmail.com);
     v3.0:
       - função myDelayMs() implementada (andlsouza@gmail.com);
     v4.0:
       - entrada digital e led RGB implementados (andlsouza@gmail.com);
     v5.0:
       - melhorias no modo abajur (andlsouza@gmail.com);
     v6.0:
       - toca musica no modo 9 (andlsouza@gmail.com);
       
 * Description:
     PicBot software.

 * Test configuration:
     MCU:             PIC18F2550
     Dev.Board:       PICTICO
     Blog KitsPiC:    https://blogkitspic.wordpress.com/
     Oscillator:      20MHz Crystal on board (48Mhz project configuration frequency)
     Ext. Modules:    1 Passive buzzer, 3 leds (R/G/B).
     SW:              mikroC PRO for PIC (https://www.mikroe.com/mikroc-pic)
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
  
//Switch declarations:
sbit SWITCH_1 at RB0_bit;
sbit SWITCH_1_Direction at TRISB0_bit;

int modo = 0; //modo de funcionamento
  
void ioPortsInit()
{
  ADCON1 = 0x0F; //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
  
  LED_VERMELHO_Direction = 0; //configurando porta RA0 como saída digital.
  LED_VERDE_Direction = 0; //configurando porta RA1 como saída digital.
  LED_AZUL_Direction = 0; //configurando porta RA2 como saída digital.
  
  // Turn OFF LEDs:
  LED_VERMELHO = 0;
  LED_VERDE = 0;
  LED_AZUL = 0;

  SWITCH_1_Direction = 1; //configurando porta RB0 como entrada digital.
  
  Sound_Init(&PORTA, 0); //Buzzer conectado ao pino RA0
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
  // Turn ON LEDs:
  LED_VERMELHO = 1;
  LED_VERDE = 1;
  LED_AZUL = 1;
  myDelayMs(meio);
  // Turn OFF LEDs:
  LED_VERMELHO = 0;
  LED_VERDE = 0;
  LED_AZUL = 0;
  myDelayMs(meio);
}

void piscaLeds()
{
  // Turn ON LEDs:
  LED_VERMELHO = 1;
  LED_VERDE = 1;
  LED_AZUL = 1;
  Delay_ms(5);
  // Turn OFF LEDs:
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
     myDelayMs(250); //aguarda um tempo de 250ms.
     
     if(SWITCH_1 == 1) //se o botão 1 estiver pressionado, então...
        {
         modo = 9; //vai para o próximo modo
         myDelayMs(500); //aguarda um tempo de 500ms.
        }
    }

}

void tocaMissao()
{
  int nota = 0;
  int duracao = 0;
  int ritmo = 1; //1 = velocidade normal, 2 = velocidade 2x, 4 = velocidade 4x.
  int ralenta = 1; //velocidade / 1

  while (modo == 9)
    {
      for(nota = 0; nota < qtdNotasMissao*2; nota += 2){
        duracao = (missao[nota + 1]*ralenta) / ritmo;
        Sound_Play(missao[nota], duracao);
        //myDelayMs(duracao); //fica muito lento (usar com ritmo 2x)
        //piscaLedsMs(duracao); //fica muito lento (usar com ritmo 2x)
        piscaLeds(); //usar esta
        
        if(SWITCH_1 == 1) //se o botão 1 estiver pressionado, então...
           {
            modo = 0; //como esse é o último modo, retorna para o modo 0
            myDelayMs(500); //aguarda um tempo de 500ms.
            break;
           }
      }
     myDelayMs(250); //aguarda um tempo de 250ms.
    }
  //TODO: NO SOUND HERE!

}

void main() {

  ioPortsInit(); //inicializa portas

  //loop:
  while (1) {

     if(SWITCH_1 == 1) //se o botão 1 estiver pressionado, então...
        {
         if(modo <= 9) //hoje conta com 10 modos (0 ao 9)
           {
            modo++; //incrementa modo
           }
           else
             {
              modo = 0; //zera modo
             }
         myDelayMs(500); //aguarda um tempo de 500ms.
        }

     //configura cor do abajur:
     if(modo == 0)
       {
        //apaga os três leds:
        LED_VERMELHO = 0;
        LED_VERDE = 0;
        LED_AZUL = 0;
       }
       else if(modo == 1)
         {
          //VERMELHO:
          LED_VERMELHO = 1;
          LED_VERDE = 0;
          LED_AZUL = 0;
         }
       else if(modo == 2)
         {
          //AMARELO:
          LED_VERMELHO = 1;
          LED_VERDE = 1;
          LED_AZUL = 0;
         }
       else if(modo == 3)
         {
          //VERDE:
          LED_VERMELHO = 0;
          LED_VERDE = 1;
          LED_AZUL = 0;
         }
       else if(modo == 4)
         {
          //VERDE ÁGUA:
          LED_VERMELHO = 0;
          LED_VERDE = 1;
          LED_AZUL = 1;
         }
       else if(modo == 5)
         {
          //AZUL:
          LED_VERMELHO = 0;
          LED_VERDE = 0;
          LED_AZUL = 1;
         }
       else if(modo == 6)
         {
          //ROXO:
          LED_VERMELHO = 1;
          LED_VERDE = 0;
          LED_AZUL = 1;
         }
       else if(modo == 7)
         {
          //BRANCO:
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
         else //qualquer outra situação...
           {
            modo = 0; //apaga todos os leds.
           }
    
  }
}