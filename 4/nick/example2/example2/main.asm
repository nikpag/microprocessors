reset:
	ldi r24 , low(RAMEND)	; αρχικοποίηση stack pointer
	out SPL , r24
	ldi r24 , high(RAMEND)
	out SPH , r24
	ser r26					; αρχικοποίηση της PORTA
	out DDRA , r26			; για έξοδο

flash:
	rcall on			; ’ναψε τα LEDs
	nop					; Να αντικατασταθούν κατάλληλα οι 2 εντολές nop
	nop					; για προσθήκη καθυστέρησης 200 ms
	rcall off			; Σβήσε τα LEDs
	nop					; Να αντικατασταθούν κατάλληλα οι 2 εντολές nop
	nop					; για προσθήκη καθυστέρησης 200 ms
	rjmp flash			; Επανέλαβε

; Υπορουτίνα για να ανάβουν τα LEDs
on:
	ser r26				; θέσε τη θύρα εξόδου των LED
	out PORTA , r26
	ret					; Γύρισε στο κύριο πρόγραμμα

; Υπορουτίνα για να σβήνουν τα LEDs
off:
	clr r26				; μηδένισε τη θύρα εξόδου των LED
	out PORTA , r26
	ret					; Γύρισε στο κύριο πρόγραμμα