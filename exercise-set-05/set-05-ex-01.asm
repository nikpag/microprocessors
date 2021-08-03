PRINT MACRO CHAR
        PUSH AX
        PUSH DX                   ; κράτα τις τιμές του καταχωρητή που θα αλλάξουν στην συνέχεια
        MOV DL,CHAR
        MOV AH,2
        INT 21H
        POP DX
        POP AX
ENDM

NEWLINE MACRO
        PUSH BX
        MOV BL,13
        PRINT BL
        MOV BL,10                 ; Κωδικός ASCII για την αλλαγή γραμμής
        PRINT BL
        POP BX
ENDM

PRINT_BYTE MACRO BYTE
        PUSH DX
        MOV DL,BYTE
        AND DL,0F0H               ; πρώτο δεκαεξαδικό ψηφίο
        SHR DL,4
        CALL PRINT_HEX_DIGIT
        MOV DL,BYTE
        AND DL,0FH                ; δεύτερο δεκαεξαδικό ψηφίο
        CALL PRINT_HEX_DIGIT
        POP DX
ENDM




DATA_SEG SEGMENT
        TABLE DB 128 DUP(?)
DATA_SEG ENDS


CODE_SEG SEGMENT
        ASSUME CS:CODE_SEG, DS:DATA_SEG

PRINT_DEC PROC NEAR
        PUSH AX
        PUSH BX
        MOV AH,0
        MOV BL,10               ; διαιρώ με 10
        DIV BL                  ; Τώρα ο AL περιέχει τις δεκάδες και ο AH τις μονάδες
        ADD AL,30H              ; ASCII κωδικός για τα ψηφία 0-9
        PRINT AL                ; Τυπώνουμε τις δεκάδες
        ADD AH,30H              ; ASCII κωδικός για τα ψηφία 0-9
        PRINT AH                ; Τυπώνουμε τις μονάδες
        POP BX
        POP AX
        RET
PRINT_DEC ENDP


PRINT_HEX_DIGIT PROC NEAR
        PUSH DX
        CMP DL,9                ; Δεκαεξαδικό ψηφίο στον DL, συγκρίνουμε με το 9 για να βρούμε αν είναι 0-9 ή A-F
        JG ADDR1
        SUB DL,07H              ; πρέπει να προσθέσουμε 30 αν το δεκαεξαδικό ψηφίο είναι 0-9 (για ASCII)
ADDR1:
        ADD DL,37H              ; πρέπει να προσθέσουμε το 37 αν το δεκαεξαδικό ψηφίο είναι A-F (για ASCII)
        PRINT DL
        POP DX
        RET
PRINT_HEX_DIGIT ENDP



MAIN PROC FAR
        MOV AX,DATA_SEG
        MOV DS,AX

        MOV BL,129              ; στοιχεία
        MOV DI,0                ; δείκτης

FILL:
        DEC BL                  ; το πρώτο στοιχείο είναι 128
        MOV TABLE[DI],BL        ; το αποθηκεύουμε στον πίνακα
        INC DI                  ; επόμενο στοιχείο του πίνακα
        CMP BL,1                ; σταματάμε το fill αν = 1
        JNE FILL
        MOV DI,0
        MOV AX,0
        INC DI                  ; ο πρώτος περιττός είναι στον δείκτη 1 (127)
ADD_ODD:

        MOV BL,TABLE[DI]        ; παίρνουμε τον περιττό αριθμό
        MOV BH,0
        ADD AX,BX               ; προσθέτουμε τον περιττό αριθμό στον AX
        INC DI
        INC DI
        CMP DI,129
        JNE ADD_ODD
        MOV BL,64
        DIV BL                  ; διαιρούμε με 64 για να βρούμε τον μέσο όρο, το αποτέλεσμα μπαίνει στον AL
        CALL PRINT_DEC
        NEWLINE

        MOV DI,0
        MOV BL,TABLE[DI]        ; αρχικοποίηση για το ελάχιστο
        MOV BH,TABLE[DI]        ; αρχικοποίηση για το μέγιστο


COMPARE:
        INC DI
        CMP BL,TABLE[DI]
        JB NOT_MIN
        MOV BL,TABLE[DI]        ; ενημέρωση του ελαχίστου

NOT_MIN:
        CMP BH,TABLE[DI]
        JA NOT_MAX
        MOV BH,TABLE[DI]        ; ενημέρωση του μεγίστου

NOT_MAX:
        CMP DI,127
        JNE COMPARE             ; τελειώνουμε αν ο DI φτάσει το 127 (ο πίνακας είναι από το 0 μέχρι το 127)
        PRINT_BYTE BH           ; μέγιστο
        PRINT " "
        PRINT_BYTE BL           ; ελάχιστο

END:MOV AX,4C00H                ; τέλος
        INT 21H

MAIN ENDP
CODE_SEG ENDS
END MAIN
