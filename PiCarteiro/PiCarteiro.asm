
_ioPortsInit:

;PiCarteiro.c,33 :: 		void ioPortsInit()
;PiCarteiro.c,35 :: 		ADCON1 = 0x0F;                  //Configurando todas as portas como entradas/saídas digitais (desabilita canais analógicos).
	MOVLW       15
	MOVWF       ADCON1+0 
;PiCarteiro.c,36 :: 		NOTIFICATION_LED_Direction = 0; //Configurando porta RD1 como saída digital.
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;PiCarteiro.c,37 :: 		NOTIFICATION_LED = 0;           //Turn OFF LED
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;PiCarteiro.c,38 :: 		IR_SENSOR_Direction = 1;        //Entrada digital
	BSF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;PiCarteiro.c,39 :: 		RESET_SWITCH_Direction = 1;     //Entrada digital
	BSF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;PiCarteiro.c,40 :: 		}
L_end_ioPortsInit:
	RETURN      0
; end of _ioPortsInit

_main:

;PiCarteiro.c,42 :: 		void main() {
;PiCarteiro.c,44 :: 		ioPortsInit();  //init ports
	CALL        _ioPortsInit+0, 0
;PiCarteiro.c,47 :: 		while (1){
L_main0:
;PiCarteiro.c,48 :: 		if(IR_SENSOR == 0) //sensor detectou algo na frente...
	BTFSC       RE1_bit+0, BitPos(RE1_bit+0) 
	GOTO        L_main2
;PiCarteiro.c,50 :: 		NOTIFICATION_LED = 1;           //Turn ON LED
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;PiCarteiro.c,51 :: 		Delay_ms(250);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       88
	MOVWF       R12, 0
	MOVLW       89
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;PiCarteiro.c,52 :: 		}
L_main2:
;PiCarteiro.c,53 :: 		if(RESET_SWITCH == 1) //switch foi pressionado...
	BTFSS       RE2_bit+0, BitPos(RE2_bit+0) 
	GOTO        L_main4
;PiCarteiro.c,55 :: 		NOTIFICATION_LED = 0;           //Turn OFF LED
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;PiCarteiro.c,56 :: 		Delay_ms(250);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       88
	MOVWF       R12, 0
	MOVLW       89
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;PiCarteiro.c,57 :: 		}
L_main4:
;PiCarteiro.c,58 :: 		}
	GOTO        L_main0
;PiCarteiro.c,59 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
