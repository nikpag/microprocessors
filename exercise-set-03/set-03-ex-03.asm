(a)

SWAP Nible MACRO Q
	PUSH PSW
	MOV A,Q 			; Q <-- A = 12345678, numbers mean bits, from MSB to LSB
	RLC						; A = 23456781
	RLC						; A = 34567812
	RLC 					; A = 45678123
	RLC 					; A = 56781234
	MOV Q,A 			; Q <-- A

	MOV A,M 			; same as above
	RLC
	RLC
	RLC
	RLC
	MOV M,A
	POP PSW
ENDM

(b)

FILL MACRO RP,X,K
	PUSH PSW
	PUSH H

	LXI H,0000H
	DAD RP 				; Add RP to H-L
	MVI A,X 			; A is the counter

COUNTDOWN:
	MVI M,K 			; Place K in the memory position pointed by H-L
	INX H 				; Point to next memory address
	DCR A 				; Decrement counter
	JNZ COUNTDOWN	; If counter is not zero, continue

	POP H
	POP PSW
ENDM

(c)

RHLR MACRO n

	PUSH PSW
	PUSH D

	MVI A,n
	CPI 00H
	JZ DONE     	; If n is zero from the start, then we are done
	MVI E,n 			; E is the counter

LOOP1:
	MOV A,H
	RAR
	MOV H,A 			; H has shifted one to the right, and the CY is ready to go to L
	MOV A,L
	RAR
	MOV L,A 			; L has shifted one to the right, and CY has LSB of L
	DCR E 				; Decrement counter
	JNZ LOOP1 		; If not finished, continue loop
DONE:
	POP D
	POP PSW
ENDM
