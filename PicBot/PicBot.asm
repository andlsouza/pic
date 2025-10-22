
_ioPortsInit:

;PicBot.c,55 :: 		void ioPortsInit()
;PicBot.c,57 :: 		ADCON1 = 0x0F; //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
	MOVLW       15
	MOVWF       ADCON1+0 
;PicBot.c,59 :: 		LED_VERMELHO_Direction = 0; //configurando porta RA0 como saída digital.
	BCF         TRISC0_bit+0, BitPos(TRISC0_bit+0) 
;PicBot.c,60 :: 		LED_VERDE_Direction = 0; //configurando porta RA1 como saída digital.
	BCF         TRISC1_bit+0, BitPos(TRISC1_bit+0) 
;PicBot.c,61 :: 		LED_AZUL_Direction = 0; //configurando porta RA2 como saída digital.
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;PicBot.c,64 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,65 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,66 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,68 :: 		SWITCH_1_Direction = 1; //configurando porta RB0 como entrada digital.
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;PicBot.c,70 :: 		Sound_Init(&PORTA, 0); //Buzzer conectado ao pino RA0
	MOVLW       PORTA+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	CLRF        FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;PicBot.c,71 :: 		}
L_end_ioPortsInit:
	RETURN      0
; end of _ioPortsInit

_myDelayMs:

;PicBot.c,73 :: 		void myDelayMs(int ms)
;PicBot.c,75 :: 		int i = 0;
	CLRF        myDelayMs_i_L0+0 
	CLRF        myDelayMs_i_L0+1 
;PicBot.c,76 :: 		for(i = 0; i <= ms; i++)
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
	GOTO        L__myDelayMs55
	MOVF        myDelayMs_i_L0+0, 0 
	SUBWF       FARG_myDelayMs_ms+0, 0 
L__myDelayMs55:
	BTFSS       STATUS+0, 0 
	GOTO        L_myDelayMs1
;PicBot.c,78 :: 		Delay_ms(1);
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
;PicBot.c,76 :: 		for(i = 0; i <= ms; i++)
	INFSNZ      myDelayMs_i_L0+0, 1 
	INCF        myDelayMs_i_L0+1, 1 
;PicBot.c,79 :: 		}
	GOTO        L_myDelayMs0
L_myDelayMs1:
;PicBot.c,80 :: 		}
L_end_myDelayMs:
	RETURN      0
; end of _myDelayMs

_piscaLedsMs:

;PicBot.c,82 :: 		void piscaLedsMs(int ms)
;PicBot.c,84 :: 		int meio = 0;
	CLRF        piscaLedsMs_meio_L0+0 
	CLRF        piscaLedsMs_meio_L0+1 
;PicBot.c,85 :: 		meio = ms/2;
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
	GOTO        L__piscaLedsMs57
	BTFSS       STATUS+0, 0 
	GOTO        L__piscaLedsMs57
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__piscaLedsMs57:
	MOVF        R0, 0 
	MOVWF       piscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       piscaLedsMs_meio_L0+1 
;PicBot.c,87 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,88 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,89 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,90 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,92 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,93 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,94 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,95 :: 		myDelayMs(meio);
	MOVF        piscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        piscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,96 :: 		}
L_end_piscaLedsMs:
	RETURN      0
; end of _piscaLedsMs

_DoNotPiscaLedsMs:

;PicBot.c,99 :: 		void DoNotPiscaLedsMs(int ms)
;PicBot.c,101 :: 		int meio = 0;
	CLRF        DoNotPiscaLedsMs_meio_L0+0 
	CLRF        DoNotPiscaLedsMs_meio_L0+1 
;PicBot.c,102 :: 		meio = ms/2;
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
	GOTO        L__DoNotPiscaLedsMs59
	BTFSS       STATUS+0, 0 
	GOTO        L__DoNotPiscaLedsMs59
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__DoNotPiscaLedsMs59:
	MOVF        R0, 0 
	MOVWF       DoNotPiscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       DoNotPiscaLedsMs_meio_L0+1 
;PicBot.c,104 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,105 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,106 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,107 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,109 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,110 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,111 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,112 :: 		myDelayMs(meio);
	MOVF        DoNotPiscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        DoNotPiscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,113 :: 		}
L_end_DoNotPiscaLedsMs:
	RETURN      0
; end of _DoNotPiscaLedsMs

_giraLeds:

;PicBot.c,115 :: 		void giraLeds()
;PicBot.c,117 :: 		int gira = 0;
	CLRF        giraLeds_gira_L0+0 
	CLRF        giraLeds_gira_L0+1 
;PicBot.c,119 :: 		while (modo == 8)
L_giraLeds4:
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds61
	MOVLW       8
	XORWF       _modo+0, 0 
L__giraLeds61:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds5
;PicBot.c,121 :: 		if(gira == 0)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds62
	MOVLW       0
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds62:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds6
;PicBot.c,123 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,124 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,125 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,126 :: 		gira = 1;
	MOVLW       1
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,127 :: 		}
	GOTO        L_giraLeds7
L_giraLeds6:
;PicBot.c,128 :: 		else if(gira == 1)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds63
	MOVLW       1
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds63:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds8
;PicBot.c,130 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,131 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,132 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,133 :: 		gira = 2;
	MOVLW       2
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,134 :: 		}
	GOTO        L_giraLeds9
L_giraLeds8:
;PicBot.c,135 :: 		else if(gira == 2)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds64
	MOVLW       2
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds64:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds10
;PicBot.c,137 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,138 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,139 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,140 :: 		gira = 3;
	MOVLW       3
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,141 :: 		}
	GOTO        L_giraLeds11
L_giraLeds10:
;PicBot.c,142 :: 		else if(gira == 3)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds65
	MOVLW       3
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds65:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds12
;PicBot.c,144 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,145 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,146 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,147 :: 		gira = 4;
	MOVLW       4
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,148 :: 		}
	GOTO        L_giraLeds13
L_giraLeds12:
;PicBot.c,149 :: 		else if(gira == 4)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds66
	MOVLW       4
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds66:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds14
;PicBot.c,151 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,152 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,153 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,154 :: 		gira = 5;
	MOVLW       5
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,155 :: 		}
	GOTO        L_giraLeds15
L_giraLeds14:
;PicBot.c,156 :: 		else if(gira == 5)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds67
	MOVLW       5
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds67:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds16
;PicBot.c,158 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,159 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,160 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,161 :: 		gira = 6;
	MOVLW       6
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,162 :: 		}
	GOTO        L_giraLeds17
L_giraLeds16:
;PicBot.c,163 :: 		else if(gira == 6)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds68
	MOVLW       6
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds68:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds18
;PicBot.c,165 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,166 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,167 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,168 :: 		gira = 1;
	MOVLW       1
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,169 :: 		}
L_giraLeds18:
L_giraLeds17:
L_giraLeds15:
L_giraLeds13:
L_giraLeds11:
L_giraLeds9:
L_giraLeds7:
;PicBot.c,170 :: 		myDelayMs(250); //aguarda um tempo de 250ms.
	MOVLW       250
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       0
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,172 :: 		if(SWITCH_1 == 1) //se o botão 1 estiver pressionado, então...
	BTFSS       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_giraLeds19
;PicBot.c,174 :: 		modo = 9; //vai para o próximo modo
	MOVLW       9
	MOVWF       _modo+0 
	MOVLW       0
	MOVWF       _modo+1 
;PicBot.c,175 :: 		myDelayMs(500); //aguarda um tempo de 500ms.
	MOVLW       244
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       1
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,176 :: 		}
L_giraLeds19:
;PicBot.c,177 :: 		}
	GOTO        L_giraLeds4
L_giraLeds5:
;PicBot.c,179 :: 		}
L_end_giraLeds:
	RETURN      0
; end of _giraLeds

_tocaCop:

;PicBot.c,181 :: 		void tocaCop()
;PicBot.c,183 :: 		int nota = 0;
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
;PicBot.c,190 :: 		while (modo == 9)
L_tocaCop20:
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tocaCop70
	MOVLW       9
	XORWF       _modo+0, 0 
L__tocaCop70:
	BTFSS       STATUS+0, 2 
	GOTO        L_tocaCop21
;PicBot.c,192 :: 		for(nota = 0; nota < qtdNotasCop*2; nota += 2)
	CLRF        tocaCop_nota_L0+0 
	CLRF        tocaCop_nota_L0+1 
L_tocaCop22:
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
	GOTO        L__tocaCop71
	MOVF        R1, 0 
	SUBWF       tocaCop_nota_L0+0, 0 
L__tocaCop71:
	BTFSC       STATUS+0, 0 
	GOTO        L_tocaCop23
;PicBot.c,194 :: 		duracao = (cop[nota + 1]*ralenta) / ritmo;
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
;PicBot.c,195 :: 		if(cop[nota] != PAUSA)
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
	GOTO        L__tocaCop72
	MOVLW       0
	XORWF       R1, 0 
L__tocaCop72:
	BTFSC       STATUS+0, 2 
	GOTO        L_tocaCop25
;PicBot.c,197 :: 		Sound_Play(cop[nota], duracao);
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
;PicBot.c,198 :: 		piscaLedsMs(duracao);
	MOVF        tocaCop_duracao_L0+0, 0 
	MOVWF       FARG_piscaLedsMs_ms+0 
	MOVF        tocaCop_duracao_L0+1, 0 
	MOVWF       FARG_piscaLedsMs_ms+1 
	CALL        _piscaLedsMs+0, 0
;PicBot.c,199 :: 		}
	GOTO        L_tocaCop26
L_tocaCop25:
;PicBot.c,202 :: 		DoNotPiscaLedsMs(duracao*2); //soundplay duration + piscaLeds duration
	MOVF        tocaCop_duracao_L0+0, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+0 
	MOVF        tocaCop_duracao_L0+1, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+1 
	RLCF        FARG_DoNotPiscaLedsMs_ms+0, 1 
	BCF         FARG_DoNotPiscaLedsMs_ms+0, 0 
	RLCF        FARG_DoNotPiscaLedsMs_ms+1, 1 
	CALL        _DoNotPiscaLedsMs+0, 0
;PicBot.c,203 :: 		}
L_tocaCop26:
;PicBot.c,205 :: 		if(SWITCH_1 == 1) //se o botão 1 estiver pressionado, então...
	BTFSS       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_tocaCop27
;PicBot.c,207 :: 		modo = 0; //como esse é o último modo, retorna para o modo 0
	CLRF        _modo+0 
	CLRF        _modo+1 
;PicBot.c,208 :: 		myDelayMs(500); //aguarda um tempo de 500ms.
	MOVLW       244
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       1
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,209 :: 		break;
	GOTO        L_tocaCop23
;PicBot.c,210 :: 		}
L_tocaCop27:
;PicBot.c,192 :: 		for(nota = 0; nota < qtdNotasCop*2; nota += 2)
	MOVLW       2
	ADDWF       tocaCop_nota_L0+0, 1 
	MOVLW       0
	ADDWFC      tocaCop_nota_L0+1, 1 
;PicBot.c,212 :: 		}//close for
	GOTO        L_tocaCop22
L_tocaCop23:
;PicBot.c,213 :: 		myDelayMs(250); //aguarda um tempo de 250ms.
	MOVLW       250
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       0
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,214 :: 		} //close while
	GOTO        L_tocaCop20
L_tocaCop21:
;PicBot.c,215 :: 		}
L_end_tocaCop:
	RETURN      0
; end of _tocaCop

_main:

;PicBot.c,217 :: 		void main() {
;PicBot.c,219 :: 		ioPortsInit(); //inicializa portas
	CALL        _ioPortsInit+0, 0
;PicBot.c,222 :: 		while (1) {
L_main28:
;PicBot.c,224 :: 		if(SWITCH_1 == 1) //se o botão 1 estiver pressionado, então...
	BTFSS       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_main30
;PicBot.c,226 :: 		if(modo <= 9) //hoje conta com 10 modos (0 ao 9)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _modo+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main74
	MOVF        _modo+0, 0 
	SUBLW       9
L__main74:
	BTFSS       STATUS+0, 0 
	GOTO        L_main31
;PicBot.c,228 :: 		modo++; //incrementa modo
	INFSNZ      _modo+0, 1 
	INCF        _modo+1, 1 
;PicBot.c,229 :: 		}
	GOTO        L_main32
L_main31:
;PicBot.c,232 :: 		modo = 0; //zera modo
	CLRF        _modo+0 
	CLRF        _modo+1 
;PicBot.c,233 :: 		}
L_main32:
;PicBot.c,234 :: 		myDelayMs(500); //aguarda um tempo de 500ms.
	MOVLW       244
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       1
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,235 :: 		}
L_main30:
;PicBot.c,238 :: 		if(modo == 0)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main75
	MOVLW       0
	XORWF       _modo+0, 0 
L__main75:
	BTFSS       STATUS+0, 2 
	GOTO        L_main33
;PicBot.c,241 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,242 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,243 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,244 :: 		}
	GOTO        L_main34
L_main33:
;PicBot.c,245 :: 		else if(modo == 1)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main76
	MOVLW       1
	XORWF       _modo+0, 0 
L__main76:
	BTFSS       STATUS+0, 2 
	GOTO        L_main35
;PicBot.c,248 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,249 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,250 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,251 :: 		}
	GOTO        L_main36
L_main35:
;PicBot.c,252 :: 		else if(modo == 2)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main77
	MOVLW       2
	XORWF       _modo+0, 0 
L__main77:
	BTFSS       STATUS+0, 2 
	GOTO        L_main37
;PicBot.c,255 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,256 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,257 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,258 :: 		}
	GOTO        L_main38
L_main37:
;PicBot.c,259 :: 		else if(modo == 3)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main78
	MOVLW       3
	XORWF       _modo+0, 0 
L__main78:
	BTFSS       STATUS+0, 2 
	GOTO        L_main39
;PicBot.c,262 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,263 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,264 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,265 :: 		}
	GOTO        L_main40
L_main39:
;PicBot.c,266 :: 		else if(modo == 4)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main79
	MOVLW       4
	XORWF       _modo+0, 0 
L__main79:
	BTFSS       STATUS+0, 2 
	GOTO        L_main41
;PicBot.c,269 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,270 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,271 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,272 :: 		}
	GOTO        L_main42
L_main41:
;PicBot.c,273 :: 		else if(modo == 5)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main80
	MOVLW       5
	XORWF       _modo+0, 0 
L__main80:
	BTFSS       STATUS+0, 2 
	GOTO        L_main43
;PicBot.c,276 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,277 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,278 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,279 :: 		}
	GOTO        L_main44
L_main43:
;PicBot.c,280 :: 		else if(modo == 6)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main81
	MOVLW       6
	XORWF       _modo+0, 0 
L__main81:
	BTFSS       STATUS+0, 2 
	GOTO        L_main45
;PicBot.c,283 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,284 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,285 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,286 :: 		}
	GOTO        L_main46
L_main45:
;PicBot.c,287 :: 		else if(modo == 7)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main82
	MOVLW       7
	XORWF       _modo+0, 0 
L__main82:
	BTFSS       STATUS+0, 2 
	GOTO        L_main47
;PicBot.c,290 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,291 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,292 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,293 :: 		}
	GOTO        L_main48
L_main47:
;PicBot.c,294 :: 		else if(modo == 8)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main83
	MOVLW       8
	XORWF       _modo+0, 0 
L__main83:
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
;PicBot.c,296 :: 		giraLeds();
	CALL        _giraLeds+0, 0
;PicBot.c,297 :: 		}
	GOTO        L_main50
L_main49:
;PicBot.c,298 :: 		else if(modo == 9)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main84
	MOVLW       9
	XORWF       _modo+0, 0 
L__main84:
	BTFSS       STATUS+0, 2 
	GOTO        L_main51
;PicBot.c,300 :: 		tocaCop();
	CALL        _tocaCop+0, 0
;PicBot.c,301 :: 		}
	GOTO        L_main52
L_main51:
;PicBot.c,304 :: 		modo = 0; //apaga todos os leds.
	CLRF        _modo+0 
	CLRF        _modo+1 
;PicBot.c,305 :: 		}
L_main52:
L_main50:
L_main48:
L_main46:
L_main44:
L_main42:
L_main40:
L_main38:
L_main36:
L_main34:
;PicBot.c,307 :: 		}
	GOTO        L_main28
;PicBot.c,308 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
