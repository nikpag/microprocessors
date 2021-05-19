.include "m16def.inc"

;r20 --> intermediate result register 1 (ir1)
;r21 --> intermediate result register 2 (ir2)
;r22 --> input (PORTA)
;r23 --> output (PORTB)
;r24 --> A
;r25 --> B
;r26 --> C
;r27 --> D
;r28 --> F0
;r29 --> F1
;r30 --> F
;r31 --> holds input

ser r22
out DDRA, r22
clr r23
out DDRB, r23

main:
	in r31, PORTA
	
	mov r24, r31
	mov r25, r31
	mov r26, r31
	mov r27, r31
	
	andi r24, 0b00000001
	
	andi r25, 0b00000010
	lsr r25
	
	andi r26, 0b00000100
	lsr r26
	lsr r26
	
	andi r27, 0b00001000
	lsr r27
	lsr r27
	lsr r27
	
	mov r20, r26
	com r20
	and r20, r24
	and r20, r25

	mov r21, r26
	and r21, r27

	or r20, r21
	com r20
	andi r20, 0b000000001
	mov r28, r20

	mov r20, r24
	or r20, r25

	mov r21, r26
	or r21, r27

	and r20, r21
	lsl r20
	mov r29, r20

	or r28, r29
	mov r30, r28

	out PORTB, r30
	
	nop ; dummy line to put breakpoint on
	
	jmp main