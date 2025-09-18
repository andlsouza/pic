
_ioPortsInit:

;PicBot.c,53 :: 		void ioPortsInit()
;PicBot.c,55 :: 		ADCON1 = 0x0F; //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
	MOVLW       15
	MOVWF       ADCON1+0 
;PicBot.c,57 :: 		LED_VERMELHO_Direction = 0; //configurando porta RA0 como saída digital.
	BCF         TRISC0_bit+0, BitPos(TRISC0_bit+0) 
;PicBot.c,58 :: 		LED_VERDE_Direction = 0; //configurando porta RA1 como saída digital.
	BCF         TRISC1_bit+0, BitPos(TRISC1_bit+0) 
;PicBot.c,59 :: 		LED_AZUL_Direction = 0; //configurando porta RA2 como saída digital.
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;PicBot.c,62 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,63 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,64 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,66 :: 		SWITCH_1_Direction = 1; //configurando porta RB0 como entrada digital.
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;PicBot.c,68 :: 		Sound_Init(&PORTA, 0); //Buzzer conectado ao pino RA0
	MOVLW       PORTA+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	CLRF        FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;PicBot.c,69 :: 		}
L_end_ioPortsInit:
	RETURN      0
; end of _ioPortsInit

_myDelayMs:

;PicBot.c,71 :: 		void myDelayMs(int ms)
;PicBot.c,73 :: 		int i = 0;
	CLRF        myDelayMs_i_L0+0 
	CLRF        myDelayMs_i_L0+1 
;PicBot.c,74 :: 		for(i = 0; i <= ms; i++)
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
	GOTO        L__myDelayMs59
	MOVF        myDelayMs_i_L0+0, 0 
	SUBWF       FARG_myDelayMs_ms+0, 0 
L__myDelayMs59:
	BTFSS       STATUS+0, 0 
	GOTO        L_myDelayMs1
;PicBot.c,76 :: 		Delay_ms(1);
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
;PicBot.c,74 :: 		for(i = 0; i <= ms; i++)
	INFSNZ      myDelayMs_i_L0+0, 1 
	INCF        myDelayMs_i_L0+1, 1 
;PicBot.c,77 :: 		}
	GOTO        L_myDelayMs0
L_myDelayMs1:
;PicBot.c,78 :: 		}
L_end_myDelayMs:
	RETURN      0
; end of _myDelayMs

_piscaLedsMs:

;PicBot.c,80 :: 		void piscaLedsMs(int ms)
;PicBot.c,82 :: 		int meio = 0;
	CLRF        piscaLedsMs_meio_L0+0 
	CLRF        piscaLedsMs_meio_L0+1 
;PicBot.c,83 :: 		meio = ms/2;
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
	GOTO        L__piscaLedsMs61
	BTFSS       STATUS+0, 0 
	GOTO        L__piscaLedsMs61
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__piscaLedsMs61:
	MOVF        R0, 0 
	MOVWF       piscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       piscaLedsMs_meio_L0+1 
;PicBot.c,85 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,86 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,87 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,88 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,90 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,91 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,92 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,93 :: 		myDelayMs(meio);
	MOVF        piscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        piscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,94 :: 		}
L_end_piscaLedsMs:
	RETURN      0
; end of _piscaLedsMs

_DoNotPiscaLedsMs:

;PicBot.c,97 :: 		void DoNotPiscaLedsMs(int ms)
;PicBot.c,99 :: 		int meio = 0;
	CLRF        DoNotPiscaLedsMs_meio_L0+0 
	CLRF        DoNotPiscaLedsMs_meio_L0+1 
;PicBot.c,100 :: 		meio = ms/2;
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
	GOTO        L__DoNotPiscaLedsMs63
	BTFSS       STATUS+0, 0 
	GOTO        L__DoNotPiscaLedsMs63
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__DoNotPiscaLedsMs63:
	MOVF        R0, 0 
	MOVWF       DoNotPiscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       DoNotPiscaLedsMs_meio_L0+1 
;PicBot.c,102 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,103 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,104 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,105 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,107 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,108 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,109 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,110 :: 		myDelayMs(meio);
	MOVF        DoNotPiscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        DoNotPiscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,111 :: 		}
L_end_DoNotPiscaLedsMs:
	RETURN      0
; end of _DoNotPiscaLedsMs

_piscaLeds:

;PicBot.c,113 :: 		void piscaLeds()
;PicBot.c,116 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,117 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,118 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,119 :: 		Delay_ms(5);
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_piscaLeds4:
	DECFSZ      R13, 1, 1
	BRA         L_piscaLeds4
	DECFSZ      R12, 1, 1
	BRA         L_piscaLeds4
;PicBot.c,121 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,122 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,123 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,124 :: 		Delay_ms(5);
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_piscaLeds5:
	DECFSZ      R13, 1, 1
	BRA         L_piscaLeds5
	DECFSZ      R12, 1, 1
	BRA         L_piscaLeds5
;PicBot.c,125 :: 		}
L_end_piscaLeds:
	RETURN      0
; end of _piscaLeds

_DoNotPiscaLeds:

;PicBot.c,128 :: 		void DoNotPiscaLeds()
;PicBot.c,131 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,132 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,133 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,134 :: 		Delay_ms(5);
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_DoNotPiscaLeds6:
	DECFSZ      R13, 1, 1
	BRA         L_DoNotPiscaLeds6
	DECFSZ      R12, 1, 1
	BRA         L_DoNotPiscaLeds6
;PicBot.c,136 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,137 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,138 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,139 :: 		Delay_ms(5);
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_DoNotPiscaLeds7:
	DECFSZ      R13, 1, 1
	BRA         L_DoNotPiscaLeds7
	DECFSZ      R12, 1, 1
	BRA         L_DoNotPiscaLeds7
;PicBot.c,140 :: 		}
L_end_DoNotPiscaLeds:
	RETURN      0
; end of _DoNotPiscaLeds

_giraLeds:

;PicBot.c,142 :: 		void giraLeds()
;PicBot.c,144 :: 		int gira = 0;
	CLRF        giraLeds_gira_L0+0 
	CLRF        giraLeds_gira_L0+1 
;PicBot.c,146 :: 		while (modo == 8)
L_giraLeds8:
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds67
	MOVLW       8
	XORWF       _modo+0, 0 
L__giraLeds67:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds9
;PicBot.c,148 :: 		if(gira == 0)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds68
	MOVLW       0
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds68:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds10
;PicBot.c,150 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,151 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,152 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,153 :: 		gira = 1;
	MOVLW       1
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,154 :: 		}
	GOTO        L_giraLeds11
L_giraLeds10:
;PicBot.c,155 :: 		else if(gira == 1)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds69
	MOVLW       1
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds69:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds12
;PicBot.c,157 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,158 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,159 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,160 :: 		gira = 2;
	MOVLW       2
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,161 :: 		}
	GOTO        L_giraLeds13
L_giraLeds12:
;PicBot.c,162 :: 		else if(gira == 2)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds70
	MOVLW       2
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds70:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds14
;PicBot.c,164 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,165 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,166 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,167 :: 		gira = 3;
	MOVLW       3
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,168 :: 		}
	GOTO        L_giraLeds15
L_giraLeds14:
;PicBot.c,169 :: 		else if(gira == 3)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds71
	MOVLW       3
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds71:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds16
;PicBot.c,171 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,172 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,173 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,174 :: 		gira = 4;
	MOVLW       4
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,175 :: 		}
	GOTO        L_giraLeds17
L_giraLeds16:
;PicBot.c,176 :: 		else if(gira == 4)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds72
	MOVLW       4
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds72:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds18
;PicBot.c,178 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,179 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,180 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,181 :: 		gira = 5;
	MOVLW       5
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,182 :: 		}
	GOTO        L_giraLeds19
L_giraLeds18:
;PicBot.c,183 :: 		else if(gira == 5)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds73
	MOVLW       5
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds73:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds20
;PicBot.c,185 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,186 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,187 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,188 :: 		gira = 6;
	MOVLW       6
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,189 :: 		}
	GOTO        L_giraLeds21
L_giraLeds20:
;PicBot.c,190 :: 		else if(gira == 6)
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds74
	MOVLW       6
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds74:
	BTFSS       STATUS+0, 2 
	GOTO        L_giraLeds22
;PicBot.c,192 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,193 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,194 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,195 :: 		gira = 1;
	MOVLW       1
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicBot.c,196 :: 		}
L_giraLeds22:
L_giraLeds21:
L_giraLeds19:
L_giraLeds17:
L_giraLeds15:
L_giraLeds13:
L_giraLeds11:
;PicBot.c,197 :: 		myDelayMs(250); //aguarda um tempo de 250ms.
	MOVLW       250
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       0
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,199 :: 		if(SWITCH_1 == 1) //se o botão 1 estiver pressionado, então...
	BTFSS       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_giraLeds23
;PicBot.c,201 :: 		modo = 9; //vai para o próximo modo
	MOVLW       9
	MOVWF       _modo+0 
	MOVLW       0
	MOVWF       _modo+1 
;PicBot.c,202 :: 		myDelayMs(500); //aguarda um tempo de 500ms.
	MOVLW       244
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       1
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,203 :: 		}
L_giraLeds23:
;PicBot.c,204 :: 		}
	GOTO        L_giraLeds8
L_giraLeds9:
;PicBot.c,206 :: 		}
L_end_giraLeds:
	RETURN      0
; end of _giraLeds

_tocaMissao:

;PicBot.c,208 :: 		void tocaMissao()
;PicBot.c,210 :: 		int nota = 0;
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
;PicBot.c,215 :: 		while (modo == 9)
L_tocaMissao24:
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tocaMissao76
	MOVLW       9
	XORWF       _modo+0, 0 
L__tocaMissao76:
	BTFSS       STATUS+0, 2 
	GOTO        L_tocaMissao25
;PicBot.c,217 :: 		for(nota = 0; nota < qtdNotasMissao*2; nota += 2){
	CLRF        tocaMissao_nota_L0+0 
	CLRF        tocaMissao_nota_L0+1 
L_tocaMissao26:
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
	GOTO        L__tocaMissao77
	MOVF        R1, 0 
	SUBWF       tocaMissao_nota_L0+0, 0 
L__tocaMissao77:
	BTFSC       STATUS+0, 0 
	GOTO        L_tocaMissao27
;PicBot.c,218 :: 		duracao = (missao[nota + 1]*ralenta) / ritmo;
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
;PicBot.c,220 :: 		if(missao[nota] != PAUSA)
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
	GOTO        L__tocaMissao78
	MOVLW       0
	XORWF       R1, 0 
L__tocaMissao78:
	BTFSC       STATUS+0, 2 
	GOTO        L_tocaMissao29
;PicBot.c,222 :: 		Sound_Play(missao[nota], duracao);
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
;PicBot.c,224 :: 		piscaLedsMs(duracao); //fica muito lento (usar com ritmo 2x)
	MOVF        tocaMissao_duracao_L0+0, 0 
	MOVWF       FARG_piscaLedsMs_ms+0 
	MOVF        tocaMissao_duracao_L0+1, 0 
	MOVWF       FARG_piscaLedsMs_ms+1 
	CALL        _piscaLedsMs+0, 0
;PicBot.c,226 :: 		}
	GOTO        L_tocaMissao30
L_tocaMissao29:
;PicBot.c,229 :: 		DoNotPiscaLedsMs(duracao*2); //soundplay duration + piscaLeds duration
	MOVF        tocaMissao_duracao_L0+0, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+0 
	MOVF        tocaMissao_duracao_L0+1, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+1 
	RLCF        FARG_DoNotPiscaLedsMs_ms+0, 1 
	BCF         FARG_DoNotPiscaLedsMs_ms+0, 0 
	RLCF        FARG_DoNotPiscaLedsMs_ms+1, 1 
	CALL        _DoNotPiscaLedsMs+0, 0
;PicBot.c,232 :: 		}
L_tocaMissao30:
;PicBot.c,234 :: 		if(SWITCH_1 == 1) //se o botão 1 estiver pressionado, então...
	BTFSS       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_tocaMissao31
;PicBot.c,236 :: 		modo = 0; //como esse é o último modo, retorna para o modo 0
	CLRF        _modo+0 
	CLRF        _modo+1 
;PicBot.c,237 :: 		myDelayMs(500); //aguarda um tempo de 500ms.
	MOVLW       244
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       1
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,238 :: 		break;
	GOTO        L_tocaMissao27
;PicBot.c,239 :: 		}
L_tocaMissao31:
;PicBot.c,217 :: 		for(nota = 0; nota < qtdNotasMissao*2; nota += 2){
	MOVLW       2
	ADDWF       tocaMissao_nota_L0+0, 1 
	MOVLW       0
	ADDWFC      tocaMissao_nota_L0+1, 1 
;PicBot.c,240 :: 		}
	GOTO        L_tocaMissao26
L_tocaMissao27:
;PicBot.c,241 :: 		myDelayMs(250); //aguarda um tempo de 250ms.
	MOVLW       250
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       0
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,242 :: 		}
	GOTO        L_tocaMissao24
L_tocaMissao25:
;PicBot.c,245 :: 		}
L_end_tocaMissao:
	RETURN      0
; end of _tocaMissao

_main:

;PicBot.c,247 :: 		void main() {
;PicBot.c,249 :: 		ioPortsInit(); //inicializa portas
	CALL        _ioPortsInit+0, 0
;PicBot.c,252 :: 		while (1) {
L_main32:
;PicBot.c,254 :: 		if(SWITCH_1 == 1) //se o botão 1 estiver pressionado, então...
	BTFSS       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_main34
;PicBot.c,256 :: 		if(modo <= 9) //hoje conta com 10 modos (0 ao 9)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _modo+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main80
	MOVF        _modo+0, 0 
	SUBLW       9
L__main80:
	BTFSS       STATUS+0, 0 
	GOTO        L_main35
;PicBot.c,258 :: 		modo++; //incrementa modo
	INFSNZ      _modo+0, 1 
	INCF        _modo+1, 1 
;PicBot.c,259 :: 		}
	GOTO        L_main36
L_main35:
;PicBot.c,262 :: 		modo = 0; //zera modo
	CLRF        _modo+0 
	CLRF        _modo+1 
;PicBot.c,263 :: 		}
L_main36:
;PicBot.c,264 :: 		myDelayMs(500); //aguarda um tempo de 500ms.
	MOVLW       244
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       1
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicBot.c,265 :: 		}
L_main34:
;PicBot.c,268 :: 		if(modo == 0)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main81
	MOVLW       0
	XORWF       _modo+0, 0 
L__main81:
	BTFSS       STATUS+0, 2 
	GOTO        L_main37
;PicBot.c,271 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,272 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,273 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,274 :: 		}
	GOTO        L_main38
L_main37:
;PicBot.c,275 :: 		else if(modo == 1)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main82
	MOVLW       1
	XORWF       _modo+0, 0 
L__main82:
	BTFSS       STATUS+0, 2 
	GOTO        L_main39
;PicBot.c,278 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,279 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,280 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,281 :: 		}
	GOTO        L_main40
L_main39:
;PicBot.c,282 :: 		else if(modo == 2)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main83
	MOVLW       2
	XORWF       _modo+0, 0 
L__main83:
	BTFSS       STATUS+0, 2 
	GOTO        L_main41
;PicBot.c,285 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,286 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,287 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,288 :: 		}
	GOTO        L_main42
L_main41:
;PicBot.c,289 :: 		else if(modo == 3)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main84
	MOVLW       3
	XORWF       _modo+0, 0 
L__main84:
	BTFSS       STATUS+0, 2 
	GOTO        L_main43
;PicBot.c,292 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,293 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,294 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,295 :: 		}
	GOTO        L_main44
L_main43:
;PicBot.c,296 :: 		else if(modo == 4)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main85
	MOVLW       4
	XORWF       _modo+0, 0 
L__main85:
	BTFSS       STATUS+0, 2 
	GOTO        L_main45
;PicBot.c,299 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,300 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,301 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,302 :: 		}
	GOTO        L_main46
L_main45:
;PicBot.c,303 :: 		else if(modo == 5)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main86
	MOVLW       5
	XORWF       _modo+0, 0 
L__main86:
	BTFSS       STATUS+0, 2 
	GOTO        L_main47
;PicBot.c,306 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,307 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,308 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,309 :: 		}
	GOTO        L_main48
L_main47:
;PicBot.c,310 :: 		else if(modo == 6)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main87
	MOVLW       6
	XORWF       _modo+0, 0 
L__main87:
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
;PicBot.c,313 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,314 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,315 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,316 :: 		}
	GOTO        L_main50
L_main49:
;PicBot.c,317 :: 		else if(modo == 7)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main88
	MOVLW       7
	XORWF       _modo+0, 0 
L__main88:
	BTFSS       STATUS+0, 2 
	GOTO        L_main51
;PicBot.c,320 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicBot.c,321 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicBot.c,322 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicBot.c,323 :: 		}
	GOTO        L_main52
L_main51:
;PicBot.c,324 :: 		else if(modo == 8)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main89
	MOVLW       8
	XORWF       _modo+0, 0 
L__main89:
	BTFSS       STATUS+0, 2 
	GOTO        L_main53
;PicBot.c,326 :: 		giraLeds();
	CALL        _giraLeds+0, 0
;PicBot.c,327 :: 		}
	GOTO        L_main54
L_main53:
;PicBot.c,328 :: 		else if(modo == 9)
	MOVLW       0
	XORWF       _modo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main90
	MOVLW       9
	XORWF       _modo+0, 0 
L__main90:
	BTFSS       STATUS+0, 2 
	GOTO        L_main55
;PicBot.c,330 :: 		tocaMissao();
	CALL        _tocaMissao+0, 0
;PicBot.c,331 :: 		}
	GOTO        L_main56
L_main55:
;PicBot.c,334 :: 		modo = 0; //apaga todos os leds.
	CLRF        _modo+0 
	CLRF        _modo+1 
;PicBot.c,335 :: 		}
L_main56:
L_main54:
L_main52:
L_main50:
L_main48:
L_main46:
L_main44:
L_main42:
L_main40:
L_main38:
;PicBot.c,337 :: 		}
	GOTO        L_main32
;PicBot.c,338 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
