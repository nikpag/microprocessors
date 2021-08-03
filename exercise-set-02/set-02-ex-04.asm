START:
	LDA 2000H		; Read
	ANI 80H			; A = A3 _ _ _ | _ _ _ _
	RRC					; A = _ A3 _ _ | _ _ _ _
	MOV B,A			; B = _ A3 _ _ | _ _ _ _
	LDA 2000H		; Read
	ANI 40H			; A = _ B3 _ _ | _ _ _ _
	ANA B				; A = _ A3andB3 _ _ | _ _ _ _
	RRC					; A = _ _ A3andB3 _ | _ _ _ _
	RRC					; A = _ _ _ A3andB3 | _ _ _ _
	RRC					; A = _ _ _ _ | A3andB3 _ _ _
	MOV D,A			; D = _ _ _ _ | A3andB3 _ _ _

	LDA 2000H		; Read
	ANI 20H			; A = _ _ A2 _ | _ _ _ _
	RRC					; A = _ _ _ A2 | _ _ _ _
	MOV B,A			; B = _ _ _ A2 | _ _ _ _
	LDA 2000H		; Read
	ANI 10H			; A = _ _ _ B2 | _ _ _ _
	ANA B				; A = _ _ _ A2andB2 | _ _ _ _
	RRC					; A = _ _ _ _| A2andB2 _ _ _
	RRC					; A = _ _ _ _ | _ A2andB2 _ _
	MOV C,A 		; C = _ _ _ _ | _ A2andB2 _ _
	MOV A,D			; A = _ _ _ _ | A3andB3 _ _ _
	RRC					; A = _ _ _ _ | _ A3andB3 _ _
	ORA C				; A = _ _ _ _ | _ (A2andB2)and(A3andB3) _ _
	ORA D				; A = _ _ _ _ | A3andB3 (A2andB2)and(A3andB3) _ _
	MOV D,A			; D = _ _ _ _ | A3andB3 (A2andB2)and(A3andB3) _ _

	LDA 2000H 	; Read
	ANI 08H			; A = _ _ _ _ | A1 _ _ _
	RRC					; A = _ _ _ _ | _ A1 _ _
	MOV B,A			; B = _ _ _ _ | _ A1 _ _
	LDA 2000H		; Read
	ANI 04H			; A = _ _ _ _ | _ B1 _ _
	XRA B				; A = _ _ _ _ | _ A1xorB1 _ _
	RRC 				; A = _ _ _ _ | _ _ A1xorB1 _
	MOV B,A			; B = _ _ _ _ | _ _ A1xorB1 _
	ORA D				; A = _ _ _ _ | A3andB3 (A2andB2)and(A3andB3) A1xorB1 _
	MOV D,A			; D = _ _ _ _ | A3andB3 (A2andB2)and(A3andB3) A1xorB1 _


	LDA 2000H 	; Read
	ANI 02H			; A = _ _ _ _ | _ _ A0 _
	RRC					; A = _ _ _ _ | _ _ _ A0
	MOV C,A			; C = _ _ _ _ | _ _ _ A0
	LDA 2000H		; Read
	ANI 01H			; A = _ _ _ _ | _ _ _ B0
	XRA C				; A = _ _ _ _ | _ _ _ A0xorB0
	MOV C,A			; C = _ _ _ _ | _ _ _ A0xorB0
	MOV A,B			; A = _ _ _ _ | _ _ A1xorB1 _
	RRC 				; A = _ _ _ _ | _ _ _ A1xorB1
	XRA C				; A = _ _ _ _ | _ _ _ (A1xorB1)xor(A0xorB0)
	MOV C,A			; C = _ _ _ _ | _ _ _ (A1xorB1)xor(A0xorB0)
	MOV A,D			; A = _ _ _ _ | A3andB3 (A2andB2)and(A3andB3) A1xorB1 _
	ORA C				; A = _ _ _ _ | A3andB3 (A2andB2)and(A3andB3) A1xorB1 (A1xorB1)xor(A0xorB0)
	CMA					; Inverse LED logic
	STA 3000H		; Output
	JMP START		; Loop forever
END
