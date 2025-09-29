
_ioPortsInit:

;PicMusics.c,42 :: 		void ioPortsInit()
;PicMusics.c,44 :: 		ADCON1 = 0x0F;              //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
	MOVLW       15
	MOVWF       ADCON1+0 
;PicMusics.c,46 :: 		LED_VERMELHO_Direction = 0; //configurando porta RC0 como saída digital.
	BCF         TRISC0_bit+0, BitPos(TRISC0_bit+0) 
;PicMusics.c,47 :: 		LED_VERDE_Direction = 0;    //configurando porta RC1 como saída digital.
	BCF         TRISC1_bit+0, BitPos(TRISC1_bit+0) 
;PicMusics.c,48 :: 		LED_AZUL_Direction = 0;     //configurando porta RC2 como saída digital.
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;PicMusics.c,50 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,51 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,52 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,54 :: 		IR_SENSOR_Direction = 1;    //Configurando porta RA2 como entrada digital
	BSF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;PicMusics.c,55 :: 		Sound_Init(&PORTA, 0);      //Buzzer conectado ao pino RA0
	MOVLW       PORTA+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	CLRF        FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;PicMusics.c,56 :: 		}
L_end_ioPortsInit:
	RETURN      0
; end of _ioPortsInit

_myDelayMs:

;PicMusics.c,59 :: 		void myDelayMs(int ms)
;PicMusics.c,61 :: 		int i = 0;
	CLRF        myDelayMs_i_L0+0 
	CLRF        myDelayMs_i_L0+1 
;PicMusics.c,62 :: 		for(i = 0; i <= ms; i++)
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
	GOTO        L__myDelayMs42
	MOVF        myDelayMs_i_L0+0, 0 
	SUBWF       FARG_myDelayMs_ms+0, 0 
L__myDelayMs42:
	BTFSS       STATUS+0, 0 
	GOTO        L_myDelayMs1
;PicMusics.c,64 :: 		Delay_ms(1);
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
;PicMusics.c,62 :: 		for(i = 0; i <= ms; i++)
	INFSNZ      myDelayMs_i_L0+0, 1 
	INCF        myDelayMs_i_L0+1, 1 
;PicMusics.c,65 :: 		}
	GOTO        L_myDelayMs0
L_myDelayMs1:
;PicMusics.c,66 :: 		}
L_end_myDelayMs:
	RETURN      0
; end of _myDelayMs

_piscaLedsMs:

;PicMusics.c,68 :: 		void piscaLedsMs(int ms)
;PicMusics.c,70 :: 		int meio = 0;
	CLRF        piscaLedsMs_meio_L0+0 
	CLRF        piscaLedsMs_meio_L0+1 
;PicMusics.c,71 :: 		meio = ms/2;
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
	GOTO        L__piscaLedsMs44
	BTFSS       STATUS+0, 0 
	GOTO        L__piscaLedsMs44
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__piscaLedsMs44:
	MOVF        R0, 0 
	MOVWF       piscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       piscaLedsMs_meio_L0+1 
;PicMusics.c,73 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,74 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,75 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,76 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,78 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,79 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,80 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,81 :: 		myDelayMs(meio);
	MOVF        piscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        piscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,82 :: 		}
L_end_piscaLedsMs:
	RETURN      0
; end of _piscaLedsMs

_DoNotPiscaLedsMs:

;PicMusics.c,85 :: 		void DoNotPiscaLedsMs(int ms)
;PicMusics.c,87 :: 		int meio = 0;
	CLRF        DoNotPiscaLedsMs_meio_L0+0 
	CLRF        DoNotPiscaLedsMs_meio_L0+1 
;PicMusics.c,88 :: 		meio = ms/2;
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
	GOTO        L__DoNotPiscaLedsMs46
	BTFSS       STATUS+0, 0 
	GOTO        L__DoNotPiscaLedsMs46
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__DoNotPiscaLedsMs46:
	MOVF        R0, 0 
	MOVWF       DoNotPiscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       DoNotPiscaLedsMs_meio_L0+1 
;PicMusics.c,90 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,91 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,92 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,93 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,95 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,96 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,97 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,98 :: 		myDelayMs(meio);
	MOVF        DoNotPiscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        DoNotPiscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMusics.c,99 :: 		}
L_end_DoNotPiscaLedsMs:
	RETURN      0
; end of _DoNotPiscaLedsMs

_giraLeds:

;PicMusics.c,101 :: 		void giraLeds()
;PicMusics.c,103 :: 		int gira = 0;
	CLRF        giraLeds_gira_L0+0 
	CLRF        giraLeds_gira_L0+1 
;PicMusics.c,105 :: 		while(IR_SENSOR == 1) //não detectou nada no sensor ir...
L_giraLeds4:
	BTFSS       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_giraLeds5
;PicMusics.c,107 :: 		switch (gira) {
	GOTO        L_giraLeds6
;PicMusics.c,108 :: 		case 0:
L_giraLeds8:
;PicMusics.c,109 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,110 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,111 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,112 :: 		gira++;
	INFSNZ      giraLeds_gira_L0+0, 1 
	INCF        giraLeds_gira_L0+1, 1 
;PicMusics.c,113 :: 		break;
	GOTO        L_giraLeds7
;PicMusics.c,114 :: 		case 1: //vermelho
L_giraLeds9:
;PicMusics.c,115 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,116 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,117 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,118 :: 		gira++;
	INFSNZ      giraLeds_gira_L0+0, 1 
	INCF        giraLeds_gira_L0+1, 1 
;PicMusics.c,119 :: 		break;
	GOTO        L_giraLeds7
;PicMusics.c,120 :: 		case 2: //amarelo
L_giraLeds10:
;PicMusics.c,121 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,122 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,123 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,124 :: 		gira++;
	INFSNZ      giraLeds_gira_L0+0, 1 
	INCF        giraLeds_gira_L0+1, 1 
;PicMusics.c,125 :: 		break;
	GOTO        L_giraLeds7
;PicMusics.c,126 :: 		case 3: //verde
L_giraLeds11:
;PicMusics.c,127 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,128 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,129 :: 		LED_AZUL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,130 :: 		gira++;
	INFSNZ      giraLeds_gira_L0+0, 1 
	INCF        giraLeds_gira_L0+1, 1 
;PicMusics.c,131 :: 		break;
	GOTO        L_giraLeds7
;PicMusics.c,132 :: 		case 4: //ciano
L_giraLeds12:
;PicMusics.c,133 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,134 :: 		LED_VERDE = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,135 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,136 :: 		gira++;
	INFSNZ      giraLeds_gira_L0+0, 1 
	INCF        giraLeds_gira_L0+1, 1 
;PicMusics.c,137 :: 		break;
	GOTO        L_giraLeds7
;PicMusics.c,138 :: 		case 5: //azul
L_giraLeds13:
;PicMusics.c,139 :: 		LED_VERMELHO = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,140 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,141 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,142 :: 		gira++;
	INFSNZ      giraLeds_gira_L0+0, 1 
	INCF        giraLeds_gira_L0+1, 1 
;PicMusics.c,143 :: 		break;
	GOTO        L_giraLeds7
;PicMusics.c,144 :: 		case 6: //roxo
L_giraLeds14:
;PicMusics.c,145 :: 		LED_VERMELHO = 1;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;PicMusics.c,146 :: 		LED_VERDE = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;PicMusics.c,147 :: 		LED_AZUL = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;PicMusics.c,148 :: 		gira = 1; //volta para o vermelho
	MOVLW       1
	MOVWF       giraLeds_gira_L0+0 
	MOVLW       0
	MOVWF       giraLeds_gira_L0+1 
;PicMusics.c,149 :: 		break;
	GOTO        L_giraLeds7
;PicMusics.c,150 :: 		default:
L_giraLeds15:
;PicMusics.c,151 :: 		gira = 0; //apaga tudo
	CLRF        giraLeds_gira_L0+0 
	CLRF        giraLeds_gira_L0+1 
;PicMusics.c,152 :: 		break;
	GOTO        L_giraLeds7
;PicMusics.c,153 :: 		}
L_giraLeds6:
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds48
	MOVLW       0
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds48:
	BTFSC       STATUS+0, 2 
	GOTO        L_giraLeds8
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds49
	MOVLW       1
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds49:
	BTFSC       STATUS+0, 2 
	GOTO        L_giraLeds9
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds50
	MOVLW       2
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds50:
	BTFSC       STATUS+0, 2 
	GOTO        L_giraLeds10
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds51
	MOVLW       3
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds51:
	BTFSC       STATUS+0, 2 
	GOTO        L_giraLeds11
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds52
	MOVLW       4
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds52:
	BTFSC       STATUS+0, 2 
	GOTO        L_giraLeds12
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds53
	MOVLW       5
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds53:
	BTFSC       STATUS+0, 2 
	GOTO        L_giraLeds13
	MOVLW       0
	XORWF       giraLeds_gira_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__giraLeds54
	MOVLW       6
	XORWF       giraLeds_gira_L0+0, 0 
L__giraLeds54:
	BTFSC       STATUS+0, 2 
	GOTO        L_giraLeds14
	GOTO        L_giraLeds15
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
L_tocaCop16:
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
	GOTO        L__tocaCop56
	MOVF        R1, 0 
	SUBWF       tocaCop_nota_L0+0, 0 
L__tocaCop56:
	BTFSC       STATUS+0, 0 
	GOTO        L_tocaCop17
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
	GOTO        L__tocaCop57
	MOVLW       0
	XORWF       R1, 0 
L__tocaCop57:
	BTFSC       STATUS+0, 2 
	GOTO        L_tocaCop19
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
	GOTO        L_tocaCop20
L_tocaCop19:
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
L_tocaCop20:
;PicMusics.c,168 :: 		for(nota = 0; nota < qtdNotasCop*2; nota += 2){
	MOVLW       2
	ADDWF       tocaCop_nota_L0+0, 1 
	MOVLW       0
	ADDWFC      tocaCop_nota_L0+1, 1 
;PicMusics.c,179 :: 		}
	GOTO        L_tocaCop16
L_tocaCop17:
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
L_tocaMissao21:
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
	GOTO        L__tocaMissao59
	MOVF        R1, 0 
	SUBWF       tocaMissao_nota_L0+0, 0 
L__tocaMissao59:
	BTFSC       STATUS+0, 0 
	GOTO        L_tocaMissao22
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
	GOTO        L__tocaMissao60
	MOVLW       0
	XORWF       R1, 0 
L__tocaMissao60:
	BTFSC       STATUS+0, 2 
	GOTO        L_tocaMissao24
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
	GOTO        L_tocaMissao25
L_tocaMissao24:
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
L_tocaMissao25:
;PicMusics.c,191 :: 		for(nota = 0; nota < qtdNotasMissao*2; nota += 2){
	MOVLW       2
	ADDWF       tocaMissao_nota_L0+0, 1 
	MOVLW       0
	ADDWFC      tocaMissao_nota_L0+1, 1 
;PicMusics.c,203 :: 		}
	GOTO        L_tocaMissao21
L_tocaMissao22:
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
	MOVLW       4
	MOVWF       tocaTfc_ritmo_L0+0 
	MOVLW       0
	MOVWF       tocaTfc_ritmo_L0+1 
	MOVLW       3
	MOVWF       tocaTfc_ralenta_L0+0 
	MOVLW       0
	MOVWF       tocaTfc_ralenta_L0+1 
;PicMusics.c,217 :: 		for(nota = 0; nota < qtdNotasTfc*2; nota += 2){
	CLRF        tocaTfc_nota_L0+0 
	CLRF        tocaTfc_nota_L0+1 
L_tocaTfc26:
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
	GOTO        L__tocaTfc62
	MOVF        R1, 0 
	SUBWF       tocaTfc_nota_L0+0, 0 
L__tocaTfc62:
	BTFSC       STATUS+0, 0 
	GOTO        L_tocaTfc27
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
	GOTO        L__tocaTfc63
	MOVLW       0
	XORWF       R1, 0 
L__tocaTfc63:
	BTFSC       STATUS+0, 2 
	GOTO        L_tocaTfc29
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
	GOTO        L_tocaTfc30
L_tocaTfc29:
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
L_tocaTfc30:
;PicMusics.c,217 :: 		for(nota = 0; nota < qtdNotasTfc*2; nota += 2){
	MOVLW       2
	ADDWF       tocaTfc_nota_L0+0, 1 
	MOVLW       0
	ADDWFC      tocaTfc_nota_L0+1, 1 
;PicMusics.c,229 :: 		}
	GOTO        L_tocaTfc26
L_tocaTfc27:
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
L_main31:
;PicMusics.c,244 :: 		if(IR_SENSOR == 0) //sensor detectou algo na frente...
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_main33
;PicMusics.c,247 :: 		if(contador == 0)
	MOVLW       0
	XORWF       main_contador_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main65
	MOVLW       0
	XORWF       main_contador_L0+0, 0 
L__main65:
	BTFSS       STATUS+0, 2 
	GOTO        L_main34
;PicMusics.c,249 :: 		tocaCop();
	CALL        _tocaCop+0, 0
;PicMusics.c,250 :: 		contador = 1;
	MOVLW       1
	MOVWF       main_contador_L0+0 
	MOVLW       0
	MOVWF       main_contador_L0+1 
;PicMusics.c,251 :: 		}
	GOTO        L_main35
L_main34:
;PicMusics.c,252 :: 		else if(contador == 1)
	MOVLW       0
	XORWF       main_contador_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main66
	MOVLW       1
	XORWF       main_contador_L0+0, 0 
L__main66:
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
;PicMusics.c,254 :: 		tocaMissao();
	CALL        _tocaMissao+0, 0
;PicMusics.c,255 :: 		contador = 2;
	MOVLW       2
	MOVWF       main_contador_L0+0 
	MOVLW       0
	MOVWF       main_contador_L0+1 
;PicMusics.c,256 :: 		}
	GOTO        L_main37
L_main36:
;PicMusics.c,257 :: 		else if(contador == 2)
	MOVLW       0
	XORWF       main_contador_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main67
	MOVLW       2
	XORWF       main_contador_L0+0, 0 
L__main67:
	BTFSS       STATUS+0, 2 
	GOTO        L_main38
;PicMusics.c,259 :: 		tocaTfc();
	CALL        _tocaTfc+0, 0
;PicMusics.c,260 :: 		contador = 0; //on last melody, reset the counter
	CLRF        main_contador_L0+0 
	CLRF        main_contador_L0+1 
;PicMusics.c,261 :: 		}
L_main38:
L_main37:
L_main35:
;PicMusics.c,263 :: 		}
	GOTO        L_main39
L_main33:
;PicMusics.c,266 :: 		giraLeds();
	CALL        _giraLeds+0, 0
;PicMusics.c,267 :: 		}
L_main39:
;PicMusics.c,269 :: 		}
	GOTO        L_main31
;PicMusics.c,270 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
