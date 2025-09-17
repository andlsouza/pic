
_main:

;Uart_test.c,31 :: 		void main() {
;Uart_test.c,33 :: 		TRISD = 0;                      // set direction to be output on PORTD
	CLRF        TRISD+0 
;Uart_test.c,34 :: 		LATD = 0x00;                    // Turn OFF LEDs on PORTD
	CLRF        LATD+0 
;Uart_test.c,36 :: 		UART1_Init(115200);             // Initialize UART module at 115200 bps
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       42
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Uart_test.c,37 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
	NOP
;Uart_test.c,39 :: 		UART1_Write_Text("Start");
	MOVLW       ?lstr1_Uart_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Uart_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Uart_test.c,40 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Uart_test.c,41 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Uart_test.c,43 :: 		while (1) {                     // Endless loop
L_main1:
;Uart_test.c,44 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;Uart_test.c,45 :: 		LATD = 0xFF;                // Turn ON LEDs on PORTD
	MOVLW       255
	MOVWF       LATD+0 
;Uart_test.c,46 :: 		Delay_ms(50);               // 1 second delay
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
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
;Uart_test.c,47 :: 		uart_rd = UART1_Read();     // read the received data,
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart_rd+0 
;Uart_test.c,48 :: 		UART1_Write(uart_rd);       // and send data via UART
	MOVF        R0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Uart_test.c,49 :: 		LATD = 0x00;                // Turn OFF LEDs on PORTD
	CLRF        LATD+0 
;Uart_test.c,50 :: 		}
L_main3:
;Uart_test.c,51 :: 		}
	GOTO        L_main1
;Uart_test.c,52 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
