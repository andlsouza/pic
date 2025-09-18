
_ioPortsInit:

;PicMorse.c,33 :: 		void ioPortsInit()
;PicMorse.c,35 :: 		ADCON1 = 0x0F;              //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
	MOVLW       15
	MOVWF       ADCON1+0 
;PicMorse.c,36 :: 		LED_VERMELHO_Direction = 0; //Configurando porta RD1 como saída digital.
	BCF         TRISD1_bit+0, BitPos(TRISD1_bit+0) 
;PicMorse.c,37 :: 		LED_VERMELHO = 0;           //Turn OFF LED
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
;PicMorse.c,38 :: 		Sound_Init(&PORTC, 1);      //Buzzer conectado ao pino RC1
	MOVLW       PORTC+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       1
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;PicMorse.c,39 :: 		}
L_end_ioPortsInit:
	RETURN      0
; end of _ioPortsInit

_myDelayMs:

;PicMorse.c,41 :: 		void myDelayMs(int ms)
;PicMorse.c,43 :: 		int i = 0;
	CLRF        myDelayMs_i_L0+0 
	CLRF        myDelayMs_i_L0+1 
;PicMorse.c,44 :: 		for(i = 0; i <= ms; i++)
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
	GOTO        L__myDelayMs13
	MOVF        myDelayMs_i_L0+0, 0 
	SUBWF       FARG_myDelayMs_ms+0, 0 
L__myDelayMs13:
	BTFSS       STATUS+0, 0 
	GOTO        L_myDelayMs1
;PicMorse.c,46 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_myDelayMs3:
	DECFSZ      R13, 1, 1
	BRA         L_myDelayMs3
	DECFSZ      R12, 1, 1
	BRA         L_myDelayMs3
;PicMorse.c,44 :: 		for(i = 0; i <= ms; i++)
	INFSNZ      myDelayMs_i_L0+0, 1 
	INCF        myDelayMs_i_L0+1, 1 
;PicMorse.c,47 :: 		}
	GOTO        L_myDelayMs0
L_myDelayMs1:
;PicMorse.c,48 :: 		}
L_end_myDelayMs:
	RETURN      0
; end of _myDelayMs

_piscaLedsMs:

;PicMorse.c,50 :: 		void piscaLedsMs(int ms)
;PicMorse.c,52 :: 		int meio = 0;
	CLRF        piscaLedsMs_meio_L0+0 
	CLRF        piscaLedsMs_meio_L0+1 
;PicMorse.c,53 :: 		meio = ms/2;
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
	GOTO        L__piscaLedsMs15
	BTFSS       STATUS+0, 0 
	GOTO        L__piscaLedsMs15
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__piscaLedsMs15:
	MOVF        R0, 0 
	MOVWF       piscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       piscaLedsMs_meio_L0+1 
;PicMorse.c,55 :: 		LED_VERMELHO = 1;
	BSF         RD1_bit+0, BitPos(RD1_bit+0) 
;PicMorse.c,56 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMorse.c,58 :: 		LED_VERMELHO = 0;
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
;PicMorse.c,59 :: 		myDelayMs(meio);
	MOVF        piscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        piscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMorse.c,60 :: 		}
L_end_piscaLedsMs:
	RETURN      0
; end of _piscaLedsMs

_DoNotPiscaLedsMs:

;PicMorse.c,62 :: 		void DoNotPiscaLedsMs(int ms) //just to spend the same time as piscaLedsMs
;PicMorse.c,64 :: 		int meio = 0;
	CLRF        DoNotPiscaLedsMs_meio_L0+0 
	CLRF        DoNotPiscaLedsMs_meio_L0+1 
;PicMorse.c,65 :: 		meio = ms/2;
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
	GOTO        L__DoNotPiscaLedsMs17
	BTFSS       STATUS+0, 0 
	GOTO        L__DoNotPiscaLedsMs17
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__DoNotPiscaLedsMs17:
	MOVF        R0, 0 
	MOVWF       DoNotPiscaLedsMs_meio_L0+0 
	MOVF        R1, 0 
	MOVWF       DoNotPiscaLedsMs_meio_L0+1 
;PicMorse.c,67 :: 		LED_VERMELHO = 0;
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
;PicMorse.c,68 :: 		myDelayMs(meio);
	MOVF        R0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        R1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMorse.c,70 :: 		LED_VERMELHO = 0;
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
;PicMorse.c,71 :: 		myDelayMs(meio);
	MOVF        DoNotPiscaLedsMs_meio_L0+0, 0 
	MOVWF       FARG_myDelayMs_ms+0 
	MOVF        DoNotPiscaLedsMs_meio_L0+1, 0 
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMorse.c,72 :: 		}
L_end_DoNotPiscaLedsMs:
	RETURN      0
; end of _DoNotPiscaLedsMs

_tocaSOS:

;PicMorse.c,74 :: 		void tocaSOS()
;PicMorse.c,76 :: 		int nota = 0;
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
;PicMorse.c,81 :: 		for(nota = 0; nota < qtdNotasSOS*2; nota += 2){
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
	GOTO        L__tocaSOS19
	MOVF        R1, 0 
	SUBWF       tocaSOS_nota_L0+0, 0 
L__tocaSOS19:
	BTFSC       STATUS+0, 0 
	GOTO        L_tocaSOS5
;PicMorse.c,82 :: 		duracao = (sos[nota + 1]*ralenta) / ritmo;
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
;PicMorse.c,83 :: 		if(sos[nota] != PAUSA)
	MOVF        tocaSOS_nota_L0+0, 0 
	MOVWF       R0 
	MOVF        tocaSOS_nota_L0+1, 0 
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
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tocaSOS20
	MOVLW       0
	XORWF       R1, 0 
L__tocaSOS20:
	BTFSC       STATUS+0, 2 
	GOTO        L_tocaSOS7
;PicMorse.c,85 :: 		Sound_Play(sos[nota], duracao);
	MOVF        tocaSOS_nota_L0+0, 0 
	MOVWF       R0 
	MOVF        tocaSOS_nota_L0+1, 0 
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
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVF        tocaSOS_duracao_L0+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        tocaSOS_duracao_L0+1, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;PicMorse.c,86 :: 		piscaLedsMs(duracao); //fica muito lento (usar com ritmo 2x)
	MOVF        tocaSOS_duracao_L0+0, 0 
	MOVWF       FARG_piscaLedsMs_ms+0 
	MOVF        tocaSOS_duracao_L0+1, 0 
	MOVWF       FARG_piscaLedsMs_ms+1 
	CALL        _piscaLedsMs+0, 0
;PicMorse.c,87 :: 		}
	GOTO        L_tocaSOS8
L_tocaSOS7:
;PicMorse.c,90 :: 		DoNotPiscaLedsMs(duracao*2); //soundplay + led duration
	MOVF        tocaSOS_duracao_L0+0, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+0 
	MOVF        tocaSOS_duracao_L0+1, 0 
	MOVWF       FARG_DoNotPiscaLedsMs_ms+1 
	RLCF        FARG_DoNotPiscaLedsMs_ms+0, 1 
	BCF         FARG_DoNotPiscaLedsMs_ms+0, 0 
	RLCF        FARG_DoNotPiscaLedsMs_ms+1, 1 
	CALL        _DoNotPiscaLedsMs+0, 0
;PicMorse.c,91 :: 		}
L_tocaSOS8:
;PicMorse.c,81 :: 		for(nota = 0; nota < qtdNotasSOS*2; nota += 2){
	MOVLW       2
	ADDWF       tocaSOS_nota_L0+0, 1 
	MOVLW       0
	ADDWFC      tocaSOS_nota_L0+1, 1 
;PicMorse.c,92 :: 		}
	GOTO        L_tocaSOS4
L_tocaSOS5:
;PicMorse.c,94 :: 		myDelayMs(500); //aguarda um tempo de 500ms.
	MOVLW       244
	MOVWF       FARG_myDelayMs_ms+0 
	MOVLW       1
	MOVWF       FARG_myDelayMs_ms+1 
	CALL        _myDelayMs+0, 0
;PicMorse.c,95 :: 		}
L_end_tocaSOS:
	RETURN      0
; end of _tocaSOS

_main:

;PicMorse.c,97 :: 		void main() {
;PicMorse.c,99 :: 		ioPortsInit();  //init ports
	CALL        _ioPortsInit+0, 0
;PicMorse.c,102 :: 		while (1){
L_main9:
;PicMorse.c,103 :: 		tocaSOS();
	CALL        _tocaSOS+0, 0
;PicMorse.c,104 :: 		}
	GOTO        L_main9
;PicMorse.c,105 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
