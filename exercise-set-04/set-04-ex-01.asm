.include "m16def.inc"

start:
	ldi r24, low(RAMEND)				; initialize stack pointer
	out SPL, r24
	ldi r24, high(RAMEND)
	out SPH, r24

	ser r24 							; r24 = 1111 1111
	out DDRA, r24						; Initialize PORTA for output

	clr r27								; r27 = 0000 0000
	out DDRB, r27						; Initialize PORTB for input

	ldi r28, 0b00000001					; r28 holds the output
	out PORTA, r28						; Print initial r28 = 0000 0001

left:
	in r26, PORTB 						; Read input from PORTB
	andi r26, 0b00000001 				; Extract LSB
	cpi r26, 0b00000001
	brne left							; Wait in this loop until PB0 becomes 1

	lsl r28 							; Shift output one bit to the left
	out PORTA, r28						; Output to leds
	cpi r28, 0b10000000					; If you have reached the end,
	breq right							; start going to the right,
	jmp left							; else continue going to the left

right:
	in r26, PORTB 						; Read input from PORTB
	andi r26, 0b00000001 				; Extract LSB
	cpi r26, 0b00000001
	brne right							; Wait in this loop until PB0 becomes 1

	lsr r28								; Shift output one bit to the right
	out PORTA, r28						; Output to leds
	cpi r28, 0b00000001 				; If you have reached the beginning,
	breq left							; start going to the left,
	jmp right 							; else continue going to the right