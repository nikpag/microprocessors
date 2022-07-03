a:
	IN  10H
	LXI H,0900H			; initial memory index 0900H
	MVI E,00H				; E <- 0
START:
	MOV M,E					; move E to HL memory location
	INR E						; E <- E + 1
	INX H						; next memory location
	MOV A,E					; A <- E
	CPI FFH					; if A = 255 then Z = 0
	JNZ START 			; if A != 255 then jump to START
	MOV M,E					; store 255 to memory

b:
	LXI B,0000H			; BC counts num of ones
	LXI H,0900H			; HL points first stored number

LOOP_ONES:
	MOV D,M					; D <- current number
	MOV A,M					; A <- current number

	MVI E,00H				; E <- 00H
	CALL COUNT_ONES	; count ones in current number
	MOV A,M					; A <- current number
	INX H						; HL points to next memory block
	CPI FFH					; if current number != 255 then
	JNZ LOOP_ONES		; loop
	JMP c						; end of b

COUNT_ONES:
	INR E						; COUNT_ONES loops while 1 <= E <= 8
	MOV A,D					; A <- shifted number
	ANI 01H					; mask LSB
	JZ SKIP					; if LSB is not 1 then goto SKIP
	INX B						; else increase BC

SKIP:
	MOV A,D
	RRC
	MOV D,A					;store to D
	MOV A,E
	CPI 08H					;if E != 8 go to COUNT_ONES
	JNZ COUNT_ONES
	RET

c:
	LXI H,0900H
	MVI D,00H				; counter of numbers in [10H, 60H]
LOOP1:
	MOV A,M					; A <- current number
	INX H						; HL <- next memory block
	CPI 10H					; if num < 10H then
	JC  LOOP1				; go to LOOP1
	CPI 61H					; if num > 61H
	JNC EXIT				; exit
	INR D						; else D <- D + 1
	JMP LOOP1

EXIT:
	RST 1
	END
