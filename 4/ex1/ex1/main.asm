.include "m16def.inc"					

ser r24 								; r24 = 1111 1111
out DDRA, r24							; Initialize PORTA for output

clr r27									; r27 = 0000 0000
out DDRB, r27							; Initialize PORTB for input

ldi r28, 0b00000001						; r28 holds the output
out PORTA, r28							; Print initial r28 = 0000 0001

left:
	in r26, PORTB
	andi r26, 0b00000001
	cpi r26, 0b00000001
	brne left							 
	
	lsl r28 							; Shift output one bit to the left				
	out PORTA, r28						; Output to leds
	cpi r28, 0b10000000					; If you have reached the end, start going to the right
	breq right							
	jmp left

right:
	in r26, PORTB
	andi r26, 0b00000001
	cpi r26, 0b00000001
	brne right

	lsr r28
	out PORTA, r28
	cpi r28, 0b00000001
	breq left
	jmp right