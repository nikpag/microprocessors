BEGIN:
	MVI A,0DH			; Interrupt mask: 00001101 (Disable 7.5, Enable 6.5, Disable 5.5)
	SIM						; Set Interrupt Mask
	LXI H,0000H		; H-L is the accumulator of the whole sum
	MVI C,40H			; Counter. 40 hex = 64 dec
	EI						; Enable interrupt
WAITING:				; Wait for all data
	MOV A,C
	CPI 00H				; Check to see if finished
	JNZ WAITING		; If not finished, continue waiting for data
	DI 						; Disable interrupt
	DAD H 				; Normally, we would shift 5 to the right (division by 32)
	DAD H 				; Instead, we move the 3 MSB of the result to H (integer part)
	DAD H 				; So we keep the digits after the comma in the 5 MSB of L
								; Like this:
								; H --> _ _ _ _ _ x x x (result of div)
								; L --> x x x x x _ _ _ (result of mod)
	HLT

RST6.5:
	PUSH PSW

	MOV A,C
	ANI 01H				; 00000001 in order to extract LSB
	JPO READ4MSB	; If LSB is 1, go read 4 MSB

	IN 20H				; Else, read 4 LSB
	ANI 0FH				; 00001111 --> x3x2x1x0 Mask
	MOV B,A 			; Store temporarily until 4 MSB come
	DCR C					; Decrement counter
	JMP 4LSBDONE	; Return to main program until we read 4 MSB

READ4MSB:
	IN 20H				; Read 4 MSB
	ANI 0FH 			; 00001111 --> x3x2x1x0 Mask
	RLC 					; Shift 4 times to the left --> MSB in right place
	RLC
	RLC
	RLC
	ORA B 				; Combine MSB with LSB

	MVI D,00H			; D-E pair is used to temporarily keep the whole result
	MOV E,A 			; D = 0 and E = A (A has 4 MSB and 4 LSB we have already read)
	DAD D 				; Add D-E to H-L (H-L is the accumulator)
	DCR C 				; Decrement counter

4LSBDONE:
	POP PSW
	EI
	RET
END
