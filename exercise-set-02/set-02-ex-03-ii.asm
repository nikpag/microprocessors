	IN  10H					; remove memory protection
START:	CALL KIND	; KIND waits for input from keyboard
 	MOV E,A					; E <- keyboard input
 	CPI 08H					; comparing input with numbers 1-8
 	JZ  D_8
	CPI 07H
	JZ  D_7
	CPI 06H
	JZ  D_6
	CPI 05H
	JZ  D_5
	CPI 04H
	JZ  D_4
	CPI 03H
	JZ  D_3
	CPI 02H
	JZ  D_2
	CPI 01H
	JZ  D_1
	MVI A,00H				; if input is not in range 1-8 then A <- 00H so we don't turn on any leds
	CMA
	STA 3000H
	JMP START				; jump to Start

SHOW: 	MOV A,D
	CMA
 	STA 3000H
	JMP START

D_1: 	MVI D,FFH		; jump to label D_i if user's input is equal to i and we turn on all the leds from index i up to 8
	JMP SHOW
D_2: 	MVI D,FEH
	JMP SHOW
D_3: 	MVI D,FCH
	JMP SHOW
D_4: 	MVI D,F8H
	JMP SHOW
D_5: 	MVI D,F0H
	JMP SHOW
D_6: 	MVI D,E0H
	JMP SHOW
D_7: 	MVI D,C0H
	JMP SHOW
D_8: 	MVI D,80H
	JMP SHOW
EXIT:
 	END
