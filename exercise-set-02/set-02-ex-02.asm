	LXI B,0064H						; 100ms delay
	MVI D,C8H							; Counter 200x100ms = 20sec

START:
	LDA 2000H							; Read dip switches
	RLC										; Get MSB
	JC START							; If not OFF, re-read

OFF1:
	LDA 2000H							; Read dip switches
	RLC										; Get MSB
	JNC OFF1							; If not ON, re-read

ON_WITH_LED_OFF:
	LDA 2000H							; Read dip switches
	RLC										; Get MSB
	JC ON_WITH_LED_OFF		; If not OFF, re-read

OFF2:
	MVI D,C8H							; Set counter to 200

COUNTDOWN:
	MVI A,00H							; Inverse LED logic
	STA 3000H							; Light all LEDs

	LDA 2000H							; Check input
	RLC										; Get MSB
	JC ON_WITH_LED_ON			; If ON, recheck for OFF

	CALL DELB							; Delay 100ms
	DCR D									; Decrement counter
	MOV A,D								; Store counter in A
	CPI 00H								; Compare with 0
	JZ TURN_OFF						; If time passed, turn off
	JMP COUNTDOWN
ON_WITH_LED_ON:
	CALL DELB
	DCR D
	MOV A,D
	CPI 00H
	JZ TURN_OFF
	LDA 2000H
	RLC
	JNC OFF2
	JNZ ON_WITH_LED_ON
TURN_OFF:
	MVI A,FFH							; Inverse LED logic
	STA 3000H							; Turn off all LEDs
	JMP START							; Loop forever
END
