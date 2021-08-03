; Τυπώνει έναν χαρακτήρα

PRINTCH MACRO CHAR
        PUSH AX
        PUSH DX
        MOV DL,CHAR
        MOV AH,2
        INT 21H
        POP DX
        POP AX
ENDM

; Τυπώνει μία συμβολοσειρά

PRINTSTR MACRO STRING
        PUSH AX
        PUSH DX
        MOV DX,OFFSET STRING
        MOV AH,9
        INT 21H
        POP DX
        POP AX
ENDM

; Τυπώνει αλλαγή γραμμής

PRINTLN MACRO
        PUSH AX
        PUSH DX
        MOV     DL,13
        MOV     AH,2
        INT     21H
        MOV     DL,10
        MOV     AH,2
        INT     21H
        POP DX
        POP AX
ENDM

; Τυπώνει ένα tab

PRINTTAB MACRO
        PUSH AX
        PUSH DX
        MOV DL,9
        MOV     AH,2
        INT     21H
        POP DX
        POP AX
ENDM

; Διαβάζει έναν χαρακτήρα και τον αποθηκεύει στον AL

READCH MACRO
        MOV AH,8
        INT 21H
ENDM

; Διαβάζει έναν χαρακτήρα και τον τυπώνει

READNPRINTCH MACRO
        MOV AH,1
        INT 21H
ENDM

; ΡΟΥΤΙΝΑ ΤΕΛΟΥΣ

EXIT MACRO
        MOV AX,4C00H
        INT 21H
ENDM