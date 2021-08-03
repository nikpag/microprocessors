START:
	IN 10H				; Remove memory protection
	MVI A,10H			; 10H --> empty LCD
	STA 0A00H			; LCD: _ _ _ _ _ x
	STA 0A01H			; LCD: _ _ _ _ x _
	STA 0A04H			; LCD: _ x _ _ _ _
	STA 0A05H			; LCD: x _ _ _ _ _

	MVI A,0DH			; 00001101 -->5.5 no, 6.5 yes, 7.5 no
	SIM 					; Set interrupt mask
 	EI						; Enable interrupt

WAIT:
	JMP WAIT			; Wait for interrupt

INTR_ROUTINE:
	POP H					; Pops PC from stack
	MVI A,00H			; Inverse LED logic
	STA 3000H			; Light up LEDs
	MVI E,3CH			; 60 sec
	EI						; For time reset

COUNTDOWN: 			;
	CALL DECA			; for LCD DEC printing
	DCR E					; E is the counter
	JNZ COUNTDOWN	; if E != 0, repeat

	MVI A,FFH			; After 60sec,
	STA 3000H			; turn off leds

	JMP WAIT

DECA: 					; Prints E in DEC to LCD
	PUSH PSW
	PUSH B
	PUSH D
	PUSH H
	MVI C,00H 		; Counts tens
	MOV A,E				; Counts ones
TENS:
	INR C					; C++
	SUI 0AH				; Subtract 10
	JNC TENS			; If not negative, repeat
ONES:
	ADI 0AH				; Correct negative
	DCR C					; Correct tens' counter

	LXI H,0A02H 	; Memory place for ones-lcd
	MOV M,A 			; Store ones
	LXI H,0A03H 	; Memory place for tens-lcd
	MOV M,C				; Store tens

	LXI D,0A00H 	; Starting position for lcd
	CALL STDM	 		; Store Display Message

	LXI B,0064H		; 100ms delay
	MVI A,0AH			; A --> cnt, 10x100ms=1sec
ONESEC:
	CALL DCD			; Print to lcd
	CALL DELB			; 100ms delay
	DCR A					; A--
	JNZ ONESEC		; If A != 0, repeat

	POP H
	POP D
	POP B
	POP PSW
	RET

END:
	RST 1
	END
