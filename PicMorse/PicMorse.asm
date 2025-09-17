
_ioPortsInit:

;PicMorse.c,31 :: 		void ioPortsInit()
;PicMorse.c,33 :: 		ADCON1 = 0x0F;              //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
	MOVLW       15
	MOVWF       ADCON1+0 
;PicMorse.c,34 :: 		LED_VERMELHO_Direction = 0; //Configurando porta RD1 como saída digital.
	BCF         TRISD1_bit+0, BitPos(TRISD1_bit+0) 
;PicMorse.c,35 :: 		LED_VERMELHO = 0;           //Turn OFF LED
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
;PicMorse.c,36 :: 		Sound_Init(&PORTC, 1);      //Buzzer conectado ao pino RC1
	MOVLW       PORTC+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       1
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;PicMorse.c,37 :: 		}
L_end_ioPortsInit:
	RETURN      0
; end of _ioPortsInit

_myDelayMs:

;PicMorse.c,39 :: 		void myDelayMs(int ms)
;PicMorse.c,41 :: 		int i = 0;
	CLRF        myDelayMs_i_L0+0 
	CLRF        myDelayMs_i_L0+1 
;PicMorse.c,42 :: 		for(i = 0; i <= ms; i++)
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
	GOTO        L__myDelayMs11
	MOVF        myDelayMs_i_L0+0, 0 
	SUBWF       FARG_myDelayMs_ms+0, 0 
L__myDelayMs11:
	BTFSS       STATUS+0, 0 
	GOTO        L_myDelayMs1
;PicMorse.c,44 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_myDelayMs3:
	DECFSZ      R13, 1, 1
	BRA         L_myDelayMs3
	DECFSZ      R12, 1, 1
	BRA         L_myDelayMs3
;PicMorse.c,42 :: 		for(i = 0; i <= ms; i++)
	INFSNZ      myDelayMs_i_L0+0, 1 
	INCF        myDelayMs_i_L0+1, 1 
;PicMorse.c,45 :: 		}
	GOTO        L_myDelayMs0
L_myDelayMs1:
;PicMorse.c,46 :: 		}
L_end_myDelayMs:
	RETURN      0
; end of _myDelayMs

_piscaLedsMs:

;PicMorse.c,48 :: 		void piscaLedsMs(int ms)
;PicMorse.c,50 :: 		int meio = 0;
	CLRF        piscaLedsMs_meio_L0+0 
	CLRF        piscaLedsMs_meio_L0+1 
;PicMorse.c,51 :: 		meio = ms/2;
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
	GOTO        L__piscaLedsMs13
	BTFSS       STATUS+0, 0 
	GOTO        L__piscaLedsMs13
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__piscaLedsMs13:
	MOVF        R0, 0 
	MOVWF       piscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       piscaLedsMs_meio_L0+1 
;PicMorse.c,53 :: 		LED_VERMELHO = 1;
	BSF         RD1_bit+0, BitPos(RD1_bit+0) 
;PicMorse.c,54 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMorse.c,56 :: 		LED_VERMELHO = 0;
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
;PicMorse.c,57 :: 		myDelayMs(meio);
	MOVF        piscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        piscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMorse.c,58 :: 		}
L_end_piscaLedsMs:
	RETURN      0
; end of _piscaLedsMs

_tocaSOS:

;PicMorse.c,60 :: 		void tocaSOS()
;PicMorse.c,62 :: 		int nota = 0;
	CLRF        tocaSOS_nota_L0+0 
	CLRF        tocaSOS_nota_L0+1 
	CLRF        tocaSOS_duracao_L0+0 
	CLRF        tocaSOS_duracao_L0+1 
	MOVLW       1
	MOVWF       tocaSOS_ritmo_L0+0 
	MOVLW       0
	MOVWF       tocaSOS_ritmo_L0+1 
	MOVLW       1
	MOVWF       tocaSOS_ralenta_L0+0 
	MOVLW       0
	MOVWF       tocaSOS_ralenta_L0+1 
;PicMorse.c,67 :: 		for(nota = 0; nota < qtdNotasSOS*2; nota += 2){
	CLRF        tocaSOS_nota_L0+0 
	CLRF        tocaSOS_nota_L0+1 
L_tocaSOS4:
	MOVF        _qtdNotasSOS+0, 0 
	MOVWF       R1 
	MOVF        _qtdNotasSOS+1, 0 
	MOVWF       R2 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R2, 1 
	MOVLW       128
	XORWF       tocaSOS_nota_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tocaSOS15
	MOVF        R1, 0 
	SUBWF       tocaSOS_nota_L0+0, 0 
L__tocaSOS15:
	BTFSC       STATUS+0, 0 
	GOTO        L_tocaSOS5
;PicMorse.c,68 :: 		duracao = (sos[nota + 1]*ralenta) / ritmo;
	MOVLW       1
	ADDWF       tocaSOS_nota_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      tocaSOS_nota_L0+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _sos+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_sos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        tocaSOS_ralenta_L0+0, 0 
	MOVWF       R4 
	MOVF        tocaSOS_ralenta_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        tocaSOS_ritmo_L0+0, 0 
	MOVWF       R4 
	MOVF        tocaSOS_ritmo_L0+1, 0 
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       tocaSOS_duracao_L0+0 
	MOVF        R1, 0 
	MOVWF       tocaSOS_duracao_L0+1 
;PicMorse.c,69 :: 		Sound_Play(sos[nota], duracao);
	MOVF        tocaSOS_nota_L0+0, 0 
	MOVWF       R2 
	MOVF        tocaSOS_nota_L0+1, 0 
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVLW       _sos+0
	ADDWF       R2, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_sos+0)
	ADDWFC      R3, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        R0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;PicMorse.c,70 :: 		piscaLedsMs(duracao); //fica muito lento (usar com ritmo 2x)
	MOVF        tocaSOS_duracao_L0+0, 0 
	MOVWF       FARG_piscaLedsMs_ms+0 
	MOVF        tocaSOS_duracao_L0+1, 0 
	MOVWF       FARG_piscaLedsMs_ms+1 
	CALL        _piscaLedsMs+0, 0
;PicMorse.c,67 :: 		for(nota = 0; nota < qtdNotasSOS*2; nota += 2){
	MOVLW       2
	ADDWF       tocaSOS_nota_L0+0, 1 
	MOVLW       0
	ADDWFC      tocaSOS_nota_L0+1, 1 
;PicMorse.c,71 :: 		}
	GOTO        L_tocaSOS4
L_tocaSOS5:
;PicMorse.c,73 :: 		myDelayMs(500); //aguarda um tempo de 500ms.
	MOVLW       244
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       1
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMorse.c,76 :: 		}
L_end_tocaSOS:
	RETURN      0
; end of _tocaSOS

_main:

;PicMorse.c,78 :: 		void main() {
;PicMorse.c,80 :: 		ioPortsInit();  //init ports
	CALL        _ioPortsInit+0, 0
;PicMorse.c,83 :: 		while (1){
L_main7:
;PicMorse.c,84 :: 		tocaSOS();
	CALL        _tocaSOS+0, 0
;PicMorse.c,85 :: 		}
	GOTO        L_main7
;PicMorse.c,86 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
