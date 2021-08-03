		IN  10H				; remove memory protection
START:
		LDA 2000H			; load input
 		MVI D,00H			; D <- 00H
 		MOV E,A				; stores initial input
 		RAR 					; shift right until first
 		JC  D_1 			; jump to label D_i if we find the first bit "1" at index i of the dip switches
		RAR
 		JC  D_2
 		RAR
		JC  D_3
		RAR
		JC  D_4
		RAR
 		JC  D_5
 		RAR
 		JC  D_6
 		RAR
 		JC  D_7
		RAR
		JC  D_8

SHOW: 						; SHOW outputs the content of A on negative logic leds
		MOV A,D
		CMA
 		STA 3000H
		JMP START

D_8: 		MVI D,80H
		MOV A,D				; A <- 10000000
		JMP SHOW
D_7: 		MVI D,40H	; A <- 01000000
		JMP SHOW
D_6: 		MVI D,20H	; A <- 00100000
		JMP SHOW
D_5: 		MVI D,10H	; A <- 00010000
		JMP SHOW
D_4: 		MVI D,08H	; A <- 00001000
		JMP SHOW
D_3: 		MVI D,04H	; A <- 00000100
		JMP SHOW
D_2: 		MVI D,02H	; A <- 00000010
		JMP SHOW
D_1: 		MVI D,01H	; A <- 00000001
		JMP SHOW
EXIT:
 		END
