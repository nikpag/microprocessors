	IN 10H
	LXI H,0A00H	  ;----------------
	MVI M,10H
	INX H
	MVI M,10H
	INX H
	MVI M,10H     ;LED screen output blank
	INX H
	MVI M,10H
	INX H
	MVI M,10H
	INX H
	MVI M,10H
	MVI A,0DH     ; --------------------
	SIM           ;Enable 6.5 Interrupts
	EI            ;----------------------

LOOP_A:     	  ;infinite loop
	JMP LOOP_A    ;wait for INTRPT

INTR_ROUTINE:

	MVI D,64H     ; D = 100
	MVI E,C8H     ; E = 200
	INR E         ; increase C,D
	INR D         ;
	CALL KIND     ; keyboard input
	LXI H,0A01H   ; load address for output of first digit given
	MOV M,A       ; first digit given = MSB
	RLC           ; rotate 4 times left to send it to MSBs and save temporarily at B
	RLC           ;
	RLC           ;
	RLC           ;
	MOV B,A
	LXI H,0A00H   ; load address for output of second digit
	CALL KIND     ; read again from keyboard
	MOV M,A       ; second digit given = LSB
	ADD B         ; add B to A
	CMP D         ;
	JC LED_1      ; if [0..K1] turn LED 0 on
	CMP E         ;
	JC LED_2      ; if (K1..K2] turn LED 1 on
	MVI A,04H     ; else if (K2..255] LED 2 on
	CMA           ; complement (negative logic LEDs)
	STA 3000H     ;
	JMP PRINT     ;
LED_1:
	MVI A,01H     ;-------------------------------------
	CMA           ; labels to turn on proper LED
	STA 3000H
	JMP PRINT
LED_2:
	MVI A,02H
	CMA
	STA 3000H
	JMP PRINT

PRINT:			   ; -------------------------------
	LXI D,0A00H    ; load to D address to show
	CALL STDM
	CALL DCD
	EI             ; enable interrupts again
	JMP PRINT      ; print until interrupt happens
END
