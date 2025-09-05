
_main:

;LedBlinking.c,25 :: 		void main() {
;LedBlinking.c,27 :: 		TRISA = 0;           // set direction to be output
	CLRF        TRISA+0 
;LedBlinking.c,28 :: 		TRISB = 0;           // set direction to be output
	CLRF        TRISB+0 
;LedBlinking.c,29 :: 		TRISC = 0;           // set direction to be output
	CLRF        TRISC+0 
;LedBlinking.c,31 :: 		do {
L_main0:
;LedBlinking.c,32 :: 		LATA = 0x00;       // Turn OFF LEDs on PORTA
	CLRF        LATA+0 
;LedBlinking.c,33 :: 		LATB = 0x00;       // Turn OFF LEDs on PORTB
	CLRF        LATB+0 
;LedBlinking.c,34 :: 		LATC = 0x00;       // Turn OFF LEDs on PORTC
	CLRF        LATC+0 
;LedBlinking.c,36 :: 		Delay_ms(1000);    // 1 second delay
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
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
;LedBlinking.c,38 :: 		LATA = 0xFF;       // Turn ON LEDs on PORTA
	MOVLW       255
	MOVWF       LATA+0 
;LedBlinking.c,39 :: 		LATB = 0xFF;       // Turn ON LEDs on PORTB
	MOVLW       255
	MOVWF       LATB+0 
;LedBlinking.c,40 :: 		LATC = 0xFF;       // Turn ON LEDs on PORTC
	MOVLW       255
	MOVWF       LATC+0 
;LedBlinking.c,42 :: 		Delay_ms(1000);    // 1 second delay
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;LedBlinking.c,44 :: 		} while(1);          // Endless loop
	GOTO        L_main0
;LedBlinking.c,45 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
