exer_3.3:
START:
	IN  10H					; turn off memory protection
	LXI H,0810H
	MVI M,10H
	INX H
	MVI M,10H
	INX H
	MVI M,10H
	INX H
	MVI M,10H
	INX H
	MVI M,10H
	INX H
	MVI M,10H


Line_0: MVI A,FEH 	; select line 0 (11111110)
       STA 2800H
       LDA 1800H 	; key input
       ANI 07H   	; keep 3 LSBs
       MVI B,85H	; FETCH PC code
       CPI 05H   	; if FETCH PC button is pressed
       JZ  PRINT	; go to PRINT
       MVI B,86H 	; INSTR STEP code
       JZ  PRINT  ; go to OUTPUT else
       CPI 06H  	; if INSTR STEP then
       JZ  PRINT  ; go to PRINT

Line_1: MVI A,FDH
	 STA 2800H
	 LDA 1800H
	 ANI 07H
	 MVI B,80H  		; FETCH REG
	 CPI 05H
	 JZ  PRINT
	 MVI B,82H  		; FETCH ADDRS
	 CPI 03H
	 JZ  PRINT
	 MVI B,84H  		; RUN
	 CPI 06H
	 JZ  PRINT

Line_2: MVI A,FBH
	 STA 2800H
	 LDA 1800H
	 ANI 07H
	 MVI B,00H  		; 0
	 CPI 06H
	 JZ PRINT
	 MVI B,81H  		; DECR
	 CPI 03H
	 JZ PRINT
	 MVI B,83H  		; STORE/INCR
	 CPI 05H
	 JZ PRINT

Line_3: MVI A,F7H
	 STA 2800H
	 LDA 1800H
	 ANI 07H
	 MVI B,01H 			; 1
	 CPI 06H
	 JZ  PRINT
	 MVI B,02H  		; 2
	 CPI 05H
	 JZ PRINT
	 MVI B,03H  		; 3
	 CPI 03H
	 JZ  PRINT

Line_4: MVI A,EFH
	 STA 2800H
	 LDA 1800H
	 ANI 07H
	 MVI B,04H  		; 4
	 CPI 06H
	 JZ  PRINT
	 MVI B,05H  		; 5
  	 CPI 05H
	 JZ  PRINT
	 MVI B,06H  		; 6
	 CPI 03H
	 JZ  PRINT

Line_5: MVI A,DFH
	 STA 2800H
	 LDA 1800H
	 ANI 07H
	 MVI B,07H  		; 7
	 CPI 06H
	 JZ  PRINT
	 MVI B,08H  		; 8
	 CPI 05H
	 JZ  PRINT
	 MVI B,09H  		; 9
	 CPI 03H
	 JZ  PRINT

Line_6: MVI A,BFH
	 STA 2800H
	 LDA 1800H
	 ANI 07H
	 MVI B,0AH  		; A
	 CPI 06H
	 JZ  PRINT
	 MVI B,0BH  		; B
	 CPI 05H
	 JZ  PRINT
	 MVI B,0CH  		; C
	 CPI 03H
	 JZ  PRINT

Line_7:
	 MVI A,7FH
	 STA 2800H
	 LDA 1800H
	 ANI 07H
	 MVI B,0DH  		; D
	 CPI 06H
	 JZ  PRINT
	 MVI B,0EH  		; E
	 CPI 05H
	 JZ  PRINT
	 MVI B,0FH  		; F
	 CPI 03H
	 JZ  PRINT

        JMP START

PRINT:
	LXI H,0815H 		; output address "0810-0815", 0815: left digit of led screen
     	MOV A,B     ; code of the button pressed
     	CPI 80H     ; if it is less than 80H: "0123456ABCDEF" then
     	JC  0TOF    ; go to 0TOF
     	MVI M,08H   ; else another button is pressed, all their codes
     	LXI H,0814H ; start with 8 which is represented by 08/LOAD NEXT ADRSS
     	SUI 80H     ; SUB 80, only next digit remains
     	MOV M,A
     	JMP SHOW
0TOF:	MVI M,00H
     	LXI H,0814H
     	MOV M,B
SHOW:	LXI D,0810H ; load address of the message
     	CALL STDM
     	CALL DCD
     	JMP START
     	END