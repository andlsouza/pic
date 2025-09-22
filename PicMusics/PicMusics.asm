
_ioPortsInit:

;PicMusics.c,40 :: 		void ioPortsInit()
;PicMusics.c,42 :: 		ADCON1 = 0x0F;              //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
	MOVLW       15
	MOVWF       ADCON1+0 
;PicMusics.c,44 :: 		LED_VERMELHO_Direction = 0; //configurando porta RC0 como saída digital.
	BCF         TRISC0_bit+0, BitPos(TRISC0_bit+0) 
;PicMusics.c,45 :: 		LED_VERDE_Direction = 0;    //configurando porta RC1 como saída digital.
	BCF         TRISC1_bit+0, BitPos(TRISC1_bit+0) 
;PicMusics.c,46 :: 		LED_AZUL_Direction = 0;     //configurando porta RC2 como saída digital.
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;PicMusics.c,48 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,49 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,50 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,52 :: 		IR_SENSOR_Direction = 1;    //Configurando porta RA2 como entrada digital
	BSF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;PicMusics.c,53 :: 		Sound_Init(&PORTA, 0);      //Buzzer conectado ao pino RA0
	MOVLW       PORTA+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	CLRF        FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;PicMusics.c,54 :: 		}
L_end_ioPortsInit:
	RETURN      0
; end of _ioPortsInit

_myDelayMs:

;PicMusics.c,57 :: 		void myDelayMs(int ms)
;PicMusics.c,59 :: 		int i = 0;
	CLRF        myDelayMs_i_L0+0 
	CLRF        myDelayMs_i_L0+1 
;PicMusics.c,60 :: 		for(i = 0; i <= ms; i++)
	CLRF        myDelayMs_i_L0+0 
	CLRF        myDelayMs_i_L0+1 
L_myDelayMs0:
	MOVLW       128
	XORWF       FARG_myDelayMs_ms+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       myDelayMs_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__myDelayMs45
	MOVF        myDelayMs_i_L0+0, 0 
	SUBWF       FARG_myDelayMs_ms+0, 0 
L__myDelayMs45:
	BTFSS       STATUS+0, 0 
	GOTO        L_myDelayMs1
;PicMusics.c,62 :: 		Delay_ms(1);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_myDelayMs3:
	DECFSZ      R13, 1, 1
	BRA         L_myDelayMs3
	DECFSZ      R12, 1, 1
	BRA         L_myDelayMs3
	NOP
;PicMusics.c,60 :: 		for(i = 0; i <= ms; i++)
	INFSNZ      myDelayMs_i_L0+0, 1 
	INCF        myDelayMs_i_L0+1, 1 
;PicMusics.c,63 :: 		}
	GOTO        L_myDelayMs0
L_myDelayMs1:
;PicMusics.c,64 :: 		}
L_end_myDelayMs:
	RETURN      0
; end of _myDelayMs

_piscaLedsMs:

;PicMusics.c,66 :: 		void piscaLedsMs(int ms)
;PicMusics.c,68 :: 		int meio = 0;
	CLRF        piscaLedsMs_meio_L0+0 
	CLRF        piscaLedsMs_meio_L0+1 
;PicMusics.c,69 :: 		meio = ms/2;
	MOVF        FARG_piscaLedsMs_ms+0, 0 
	MOVWF       R0 
	MOVF        FARG_piscaLedsMs_ms+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	BTFSS       R1, 7 
	GOTO        L__piscaLedsMs47
	BTFSS       STATUS+0, 0 
	GOTO        L__piscaLedsMs47
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__piscaLedsMs47:
	MOVF        R0, 0 
	MOVWF       piscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       piscaLedsMs_meio_L0+1 
;PicMusics.c,71 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,72 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,73 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,74 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,76 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,77 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,78 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,79 :: 		myDelayMs(meio);
	MOVF        piscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        piscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,80 :: 		}
L_end_piscaLedsMs:
	RETURN      0
; end of _piscaLedsMs

_DoNotPiscaLedsMs:

;PicMusics.c,83 :: 		void DoNotPiscaLedsMs(int ms)
;PicMusics.c,85 :: 		int meio = 0;
	CLRF        DoNotPiscaLedsMs_meio_L0+0 
	CLRF        DoNotPiscaLedsMs_meio_L0+1 
;PicMusics.c,86 :: 		meio = ms/2;
	MOVF        FARG_DoNotPiscaLedsMs_ms+0, 0 
	MOVWF       R0 
	MOVF        FARG_DoNotPiscaLedsMs_ms+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	BTFSS       R1, 7 
	GOTO        L__DoNotPiscaLedsMs49
	BTFSS       STATUS+0, 0 
	GOTO        L__DoNotPiscaLedsMs49
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__DoNotPiscaLedsMs49:
	MOVF        R0, 0 
	MOVWF       DoNotPiscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       DoNotPiscaLedsMs_meio_L0+1 
;PicMusics.c,88 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,89 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,90 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,91 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,93 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,94 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,95 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,96 :: 		myDelayMs(meio);
	MOVF        DoNotPiscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        DoNotPiscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,97 :: 		}
L_end_DoNotPiscaLedsMs:
	RETURN      0
; end of _DoNotPiscaLedsMs

_giraLeds:

;PicMusics.c,99 :: 		void giraLeds()
;PicMusics.c,101 :: 		int gira = 0;
	CLRF        giraLeds_gira_L0+0 
	CLRF        giraLeds_gira_L0+1 
;PicMusics.c,103 :: 		while(IR_SENSOR == 1) //não detectou nada no sensor ir...
L_giraLeds4:
	BTFSS       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_giraLeds5
;PicMusics.c,105 :: 		if(gira == 0) //tudo apagado
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds51
	MOVLW       0
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds51:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds6
;PicMusics.c,107 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,108 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,109 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,110 :: 		gira = 1;
	MOVLW       1
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicMusics.c,111 :: 		}
	GOTO        L_giraLeds7
L_giraLeds6:
;PicMusics.c,112 :: 		else if(gira == 1) //vermelho
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds52
	MOVLW       1
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds52:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds8
;PicMusics.c,114 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,115 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,116 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,117 :: 		gira = 2;
	MOVLW       2
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicMusics.c,118 :: 		}
	GOTO        L_giraLeds9
L_giraLeds8:
;PicMusics.c,119 :: 		else if(gira == 2) //amarelo
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds53
	MOVLW       2
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds53:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds10
;PicMusics.c,121 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,122 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,123 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,124 :: 		gira = 3;
	MOVLW       3
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicMusics.c,125 :: 		}
	GOTO        L_giraLeds11
L_giraLeds10:
;PicMusics.c,126 :: 		else if(gira == 3) //verde
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds54
	MOVLW       3
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds54:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds12
;PicMusics.c,128 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,129 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,130 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,131 :: 		gira = 4;
	MOVLW       4
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicMusics.c,132 :: 		}
	GOTO        L_giraLeds13
L_giraLeds12:
;PicMusics.c,133 :: 		else if(gira == 4) //ciano
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds55
	MOVLW       4
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds55:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds14
;PicMusics.c,135 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,136 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,137 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,138 :: 		gira = 5;
	MOVLW       5
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicMusics.c,139 :: 		}
	GOTO        L_giraLeds15
L_giraLeds14:
;PicMusics.c,140 :: 		else if(gira == 5) //azul
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds56
	MOVLW       5
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds56:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds16
;PicMusics.c,142 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,143 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,144 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,145 :: 		gira = 6;
	MOVLW       6
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicMusics.c,146 :: 		}
	GOTO        L_giraLeds17
L_giraLeds16:
;PicMusics.c,147 :: 		else if(gira == 6) //roxo
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds57
	MOVLW       6
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds57:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds18
;PicMusics.c,149 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,150 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,151 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,152 :: 		gira = 1; //volta para vermelho
	MOVLW       1
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicMusics.c,153 :: 		}
L_giraLeds18:
L_giraLeds17:
L_giraLeds15:
L_giraLeds13:
L_giraLeds11:
L_giraLeds9:
L_giraLeds7:
;PicMusics.c,154 :: 		myDelayMs(250); //aguarda um tempo de 250ms.
	MOVLW       250
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       0
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,155 :: 		}
	GOTO        L_giraLeds4
L_giraLeds5:
;PicMusics.c,157 :: 		}
L_end_giraLeds:
	RETURN      0
; end of _giraLeds

_tocaCop:

;PicMusics.c,159 :: 		void tocaCop()
;PicMusics.c,161 :: 		int nota = 0;
	CLRF        tocaCop_nota_L0+0 
	CLRF        tocaCop_nota_L0+1 
	CLRF        tocaCop_duracao_L0+0 
	CLRF        tocaCop_duracao_L0+1 
	MOVLW       3
	MOVWF       tocaCop_ritmo_L0+0 
	MOVLW       0
	MOVWF       tocaCop_ritmo_L0+1 
	MOVLW       2
	MOVWF       tocaCop_ralenta_L0+0 
	MOVLW       0
	MOVWF       tocaCop_ralenta_L0+1 
;PicMusics.c,168 :: 		for(nota = 0; nota < qtdNotasCop*2; nota += 2){
	CLRF        tocaCop_nota_L0+0 
	CLRF        tocaCop_nota_L0+1 
L_tocaCop19:
	MOVF        _qtdNotasCop+0, 0 
	MOVWF       R1 
	MOVF        _qtdNotasCop+1, 0 
	MOVWF       R2 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R2, 1 
	MOVLW       128
	XORWF       tocaCop_nota_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tocaCop59
	MOVF        R1, 0 
	SUBWF       tocaCop_nota_L0+0, 0 
L__tocaCop59:
	BTFSC       STATUS+0, 0 
	GOTO        L_tocaCop20
;PicMusics.c,169 :: 		duracao = (cop[nota + 1]*ralenta) / ritmo;
	MOVLW       1
	ADDWF       tocaCop_nota_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      tocaCop_nota_L0+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _cop+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_cop+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        tocaCop_ralenta_L0+0, 0 
	MOVWF       R4 
	MOVF        tocaCop_ralenta_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        tocaCop_ritmo_L0+0, 0 
	MOVWF       R4 
	MOVF        tocaCop_ritmo_L0+1, 0 
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       tocaCop_duracao_L0+0 
	MOVF        R1, 0 
	MOVWF       tocaCop_duracao_L0+1 
;PicMusics.c,170 :: 		if(cop[nota] != PAUSA)
	MOVF        tocaCop_nota_L0+0, 0 
	MOVWF       R0 
	MOVF        tocaCop_nota_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _cop+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_cop+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tocaCop60
	MOVLW       0
	XORWF       R1, 0 
L__tocaCop60:
	BTFSC       STATUS+0, 2 
	GOTO        L_tocaCop22
;PicMusics.c,172 :: 		Sound_Play(cop[nota], duracao);
	MOVF        tocaCop_nota_L0+0, 0 
	MOVWF       R0 
	MOVF        tocaCop_nota_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _cop+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_cop+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        tocaCop_duracao_L0+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        tocaCop_duracao_L0+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;PicMusics.c,173 :: 		piscaLedsMs(duracao);
	MOVF        tocaCop_duracao_L0+0, 0 
	MOVWF       FARG_piscaLedsMs_ms+0 
	MOVF        tocaCop_duracao_L0+1, 0 
	MOVWF       FARG_piscaLedsMs_ms+1 
	CALL        _piscaLedsMs+0, 0
;PicMusics.c,174 :: 		}
	GOTO        L_tocaCop23
L_tocaCop22:
;PicMusics.c,177 :: 		DoNotPiscaLedsMs(duracao*2); //soundplay duration + piscaLeds duration
	MOVF        tocaCop_duracao_L0+0, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+0 
	MOVF        tocaCop_duracao_L0+1, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+1 
	RLCF        FARG_DoNotPiscaLedsMs_ms+0, 1 
	BCF         FARG_DoNotPiscaLedsMs_ms+0, 0 
	RLCF        FARG_DoNotPiscaLedsMs_ms+1, 1 
	CALL        _DoNotPiscaLedsMs+0, 0
;PicMusics.c,178 :: 		}
L_tocaCop23:
;PicMusics.c,168 :: 		for(nota = 0; nota < qtdNotasCop*2; nota += 2){
	MOVLW       2
	ADDWF       tocaCop_nota_L0+0, 1 
	MOVLW       0
	ADDWFC      tocaCop_nota_L0+1, 1 
;PicMusics.c,179 :: 		}
	GOTO        L_tocaCop19
L_tocaCop20:
;PicMusics.c,181 :: 		myDelayMs(250); //aguarda um tempo de 250ms.
	MOVLW       250
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       0
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,182 :: 		}
L_end_tocaCop:
	RETURN      0
; end of _tocaCop

_tocaMissao:

;PicMusics.c,184 :: 		void tocaMissao()
;PicMusics.c,186 :: 		int nota = 0;
	CLRF        tocaMissao_nota_L0+0 
	CLRF        tocaMissao_nota_L0+1 
	CLRF        tocaMissao_duracao_L0+0 
	CLRF        tocaMissao_duracao_L0+1 
	MOVLW       2
	MOVWF       tocaMissao_ritmo_L0+0 
	MOVLW       0
	MOVWF       tocaMissao_ritmo_L0+1 
	MOVLW       1
	MOVWF       tocaMissao_ralenta_L0+0 
	MOVLW       0
	MOVWF       tocaMissao_ralenta_L0+1 
;PicMusics.c,191 :: 		for(nota = 0; nota < qtdNotasMissao*2; nota += 2){
	CLRF        tocaMissao_nota_L0+0 
	CLRF        tocaMissao_nota_L0+1 
L_tocaMissao24:
	MOVF        _qtdNotasMissao+0, 0 
	MOVWF       R1 
	MOVF        _qtdNotasMissao+1, 0 
	MOVWF       R2 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R2, 1 
	MOVLW       128
	XORWF       tocaMissao_nota_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tocaMissao62
	MOVF        R1, 0 
	SUBWF       tocaMissao_nota_L0+0, 0 
L__tocaMissao62:
	BTFSC       STATUS+0, 0 
	GOTO        L_tocaMissao25
;PicMusics.c,192 :: 		duracao = (missao[nota + 1]*ralenta) / ritmo;
	MOVLW       1
	ADDWF       tocaMissao_nota_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      tocaMissao_nota_L0+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _missao+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_missao+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        tocaMissao_ralenta_L0+0, 0 
	MOVWF       R4 
	MOVF        tocaMissao_ralenta_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        tocaMissao_ritmo_L0+0, 0 
	MOVWF       R4 
	MOVF        tocaMissao_ritmo_L0+1, 0 
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       tocaMissao_duracao_L0+0 
	MOVF        R1, 0 
	MOVWF       tocaMissao_duracao_L0+1 
;PicMusics.c,194 :: 		if(missao[nota] != PAUSA)
	MOVF        tocaMissao_nota_L0+0, 0 
	MOVWF       R0 
	MOVF        tocaMissao_nota_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _missao+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_missao+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tocaMissao63
	MOVLW       0
	XORWF       R1, 0 
L__tocaMissao63:
	BTFSC       STATUS+0, 2 
	GOTO        L_tocaMissao27
;PicMusics.c,196 :: 		Sound_Play(missao[nota], duracao);
	MOVF        tocaMissao_nota_L0+0, 0 
	MOVWF       R0 
	MOVF        tocaMissao_nota_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _missao+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_missao+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        tocaMissao_duracao_L0+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        tocaMissao_duracao_L0+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;PicMusics.c,197 :: 		piscaLedsMs(duracao);
	MOVF        tocaMissao_duracao_L0+0, 0 
	MOVWF       FARG_piscaLedsMs_ms+0 
	MOVF        tocaMissao_duracao_L0+1, 0 
	MOVWF       FARG_piscaLedsMs_ms+1 
	CALL        _piscaLedsMs+0, 0
;PicMusics.c,198 :: 		}
	GOTO        L_tocaMissao28
L_tocaMissao27:
;PicMusics.c,201 :: 		DoNotPiscaLedsMs(duracao*2); //soundplay duration + piscaLeds duration
	MOVF        tocaMissao_duracao_L0+0, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+0 
	MOVF        tocaMissao_duracao_L0+1, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+1 
	RLCF        FARG_DoNotPiscaLedsMs_ms+0, 1 
	BCF         FARG_DoNotPiscaLedsMs_ms+0, 0 
	RLCF        FARG_DoNotPiscaLedsMs_ms+1, 1 
	CALL        _DoNotPiscaLedsMs+0, 0
;PicMusics.c,202 :: 		}
L_tocaMissao28:
;PicMusics.c,191 :: 		for(nota = 0; nota < qtdNotasMissao*2; nota += 2){
	MOVLW       2
	ADDWF       tocaMissao_nota_L0+0, 1 
	MOVLW       0
	ADDWFC      tocaMissao_nota_L0+1, 1 
;PicMusics.c,203 :: 		}
	GOTO        L_tocaMissao24
L_tocaMissao25:
;PicMusics.c,205 :: 		myDelayMs(250); //aguarda um tempo de 250ms.
	MOVLW       250
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       0
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,206 :: 		}
L_end_tocaMissao:
	RETURN      0
; end of _tocaMissao

_tocaTfc:

;PicMusics.c,208 :: 		void tocaTfc()
;PicMusics.c,210 :: 		int nota = 0;
	CLRF        tocaTfc_nota_L0+0 
	CLRF        tocaTfc_nota_L0+1 
	CLRF        tocaTfc_duracao_L0+0 
	CLRF        tocaTfc_duracao_L0+1 
	MOVLW       3
	MOVWF       tocaTfc_ritmo_L0+0 
	MOVLW       0
	MOVWF       tocaTfc_ritmo_L0+1 
	MOVLW       2
	MOVWF       tocaTfc_ralenta_L0+0 
	MOVLW       0
	MOVWF       tocaTfc_ralenta_L0+1 
;PicMusics.c,217 :: 		for(nota = 0; nota < qtdNotasTfc*2; nota += 2){
	CLRF        tocaTfc_nota_L0+0 
	CLRF        tocaTfc_nota_L0+1 
L_tocaTfc29:
	MOVF        _qtdNotasTfc+0, 0 
	MOVWF       R1 
	MOVF        _qtdNotasTfc+1, 0 
	MOVWF       R2 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R2, 1 
	MOVLW       128
	XORWF       tocaTfc_nota_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tocaTfc65
	MOVF        R1, 0 
	SUBWF       tocaTfc_nota_L0+0, 0 
L__tocaTfc65:
	BTFSC       STATUS+0, 0 
	GOTO        L_tocaTfc30
;PicMusics.c,218 :: 		duracao = (tfc[nota + 1]*ralenta) / ritmo;
	MOVLW       1
	ADDWF       tocaTfc_nota_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      tocaTfc_nota_L0+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _tfc+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_tfc+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        tocaTfc_ralenta_L0+0, 0 
	MOVWF       R4 
	MOVF        tocaTfc_ralenta_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        tocaTfc_ritmo_L0+0, 0 
	MOVWF       R4 
	MOVF        tocaTfc_ritmo_L0+1, 0 
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       tocaTfc_duracao_L0+0 
	MOVF        R1, 0 
	MOVWF       tocaTfc_duracao_L0+1 
;PicMusics.c,220 :: 		if(tfc[nota] != PAUSA)
	MOVF        tocaTfc_nota_L0+0, 0 
	MOVWF       R0 
	MOVF        tocaTfc_nota_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _tfc+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_tfc+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tocaTfc66
	MOVLW       0
	XORWF       R1, 0 
L__tocaTfc66:
	BTFSC       STATUS+0, 2 
	GOTO        L_tocaTfc32
;PicMusics.c,222 :: 		Sound_Play(tfc[nota], duracao);
	MOVF        tocaTfc_nota_L0+0, 0 
	MOVWF       R0 
	MOVF        tocaTfc_nota_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _tfc+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_tfc+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        tocaTfc_duracao_L0+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        tocaTfc_duracao_L0+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;PicMusics.c,223 :: 		piscaLedsMs(duracao);
	MOVF        tocaTfc_duracao_L0+0, 0 
	MOVWF       FARG_piscaLedsMs_ms+0 
	MOVF        tocaTfc_duracao_L0+1, 0 
	MOVWF       FARG_piscaLedsMs_ms+1 
	CALL        _piscaLedsMs+0, 0
;PicMusics.c,224 :: 		}
	GOTO        L_tocaTfc33
L_tocaTfc32:
;PicMusics.c,227 :: 		DoNotPiscaLedsMs(duracao*2); //soundplay duration + piscaLeds duration
	MOVF        tocaTfc_duracao_L0+0, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+0 
	MOVF        tocaTfc_duracao_L0+1, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+1 
	RLCF        FARG_DoNotPiscaLedsMs_ms+0, 1 
	BCF         FARG_DoNotPiscaLedsMs_ms+0, 0 
	RLCF        FARG_DoNotPiscaLedsMs_ms+1, 1 
	CALL        _DoNotPiscaLedsMs+0, 0
;PicMusics.c,228 :: 		}
L_tocaTfc33:
;PicMusics.c,217 :: 		for(nota = 0; nota < qtdNotasTfc*2; nota += 2){
	MOVLW       2
	ADDWF       tocaTfc_nota_L0+0, 1 
	MOVLW       0
	ADDWFC      tocaTfc_nota_L0+1, 1 
;PicMusics.c,229 :: 		}
	GOTO        L_tocaTfc29
L_tocaTfc30:
;PicMusics.c,231 :: 		myDelayMs(250); //aguarda um tempo de 250ms.
	MOVLW       250
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       0
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,232 :: 		}
L_end_tocaTfc:
	RETURN      0
; end of _tocaTfc

_main:

;PicMusics.c,234 :: 		void main() {
;PicMusics.c,236 :: 		int contador = 0;
	CLRF        main_contador_L0+0 
	CLRF        main_contador_L0+1 
;PicMusics.c,238 :: 		ioPortsInit();  //init ports
	CALL        _ioPortsInit+0, 0
;PicMusics.c,240 :: 		myDelayMs(250); //250ms delay to reprog if needed.
	MOVLW       250
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       0
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,243 :: 		while (1){
L_main34:
;PicMusics.c,244 :: 		if(IR_SENSOR == 0) //sensor detectou algo na frente...
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_main36
;PicMusics.c,247 :: 		if(contador == 0)
	MOVLW       0
	XORWF       main_contador_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main68
	MOVLW       0
	XORWF       main_contador_L0+0, 0 
L__main68:
	BTFSS       STATUS+0, 2 
	GOTO        L_main37
;PicMusics.c,249 :: 		tocaCop();
	CALL        _tocaCop+0, 0
;PicMusics.c,250 :: 		contador = 1;
	MOVLW       1
	MOVWF       main_contador_L0+0 
	MOVLW       0
	MOVWF       main_contador_L0+1 
;PicMusics.c,251 :: 		}
	GOTO        L_main38
L_main37:
;PicMusics.c,252 :: 		else if(contador == 1)
	MOVLW       0
	XORWF       main_contador_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main69
	MOVLW       1
	XORWF       main_contador_L0+0, 0 
L__main69:
	BTFSS       STATUS+0, 2 
	GOTO        L_main39
;PicMusics.c,254 :: 		tocaMissao();
	CALL        _tocaMissao+0, 0
;PicMusics.c,255 :: 		contador = 2;
	MOVLW       2
	MOVWF       main_contador_L0+0 
	MOVLW       0
	MOVWF       main_contador_L0+1 
;PicMusics.c,256 :: 		}
	GOTO        L_main40
L_main39:
;PicMusics.c,257 :: 		else if(contador == 2)
	MOVLW       0
	XORWF       main_contador_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main70
	MOVLW       2
	XORWF       main_contador_L0+0, 0 
L__main70:
	BTFSS       STATUS+0, 2 
	GOTO        L_main41
;PicMusics.c,259 :: 		tocaTfc();
	CALL        _tocaTfc+0, 0
;PicMusics.c,260 :: 		contador = 0; //on last melody, reset the counter
	CLRF        main_contador_L0+0 
	CLRF        main_contador_L0+1 
;PicMusics.c,261 :: 		}
L_main41:
L_main40:
L_main38:
;PicMusics.c,263 :: 		}
	GOTO        L_main42
L_main36:
;PicMusics.c,266 :: 		giraLeds();
	CALL        _giraLeds+0, 0
;PicMusics.c,267 :: 		}
L_main42:
;PicMusics.c,269 :: 		}
	GOTO        L_main34
;PicMusics.c,270 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
