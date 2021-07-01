;------------------------------------------------------------------------------------------------
; ΑΥΤΟΣ Ο ΚΩΔΙΚΑΣ ΔΕΝ ΑΦΟΡΑ ΤΙΣ ΡΟΥΤΙΝΕΣ, ΕΙΝΑΙ ΜΟΝΟ ΓΙΑ ΝΑ ΤΡΕΧΕΙ ΤΟ ΠΡΟΓΡΑΜΜΑ ΣΤΟΝ ΠΡΟΣΟΜΟΙΩΤΗ
; ΟΙ ΡΟΥΤΙΝΕΣ ΒΡΙΣΚΟΝΤΑΙ ΠΙΟ ΚΑΤΩ, ΕΚΕΙ ΠΟΥ ΑΝΑΓΡΑΦΟΝΤΑΙ ΤΑ ΑΝΤΙΣΤΟΙΧΑ LABELS!!!
;------------------------------------------------------------------------------------------------


INCLUDE MACROS.ASM
        .8086
        .MODEL SMALL
        .STACK 256

;------DATA SEGMENT------------------------------------------------------------

.DATA
        EQUAL DB "=$"

;------CODE SEGMENT------------------------------------------------------------

.CODE

;----MAIN----------------------------------------------------------------------

MAIN PROC FAR
        MOV AX,@DATA
        MOV DS,AX
START:
        MOV CX, 3
ADDR1:
        CALL HEX_KEYB
        CMP AL, 'T'
        JE QUIT                         ; αν διαβάσεις "Τ" τότε τερμάτισε το πρόγραμμα
        SHL BX, 1
        SHL BX, 1
        SHL BX, 1
        SHL BX, 1
        ADD BL, AL                      ; ο BX θα περιέχει τον 3ψήφιο δεκαεξαδικό αριθμό
        LOOP ADDR1
        PRINT '='
        PUSH BX
        CALL PRINT_DEC
        PRINT '='
        POP BX
        PUSH BX
        CALL PRINT_OCT
        PRINT '='
        POP BX
        CALL PRINT_BIN
        NEW_LINE
        JMP START                       ; το πρόγραμμα τρέχει συνεχώς
QUIT:
        MOV ax, 4c00h                   ; έξοδος
        INT 21h
MAIN ENDP


; Δουλεύει για 0-9 και για A-F
HEX_KEYB PROC NEAR                      ; η ρουτίνα διαβάζει ένα δεκαεξαδικό ψηφίο από το πληκτρολόγιο και το επιστρέφει ως δυαδικό μέσω του AL

PUSH DX                                 ; Ο καταχωρητής DX επηρεάζεται από την macro PRINT
IGNORE:
        READ                            ; Διάβασε τον χαρακτήρα από το πληκτρολόγιο
        CMP AL, 'Q'                     ; Αν είναι ο χαρακτήρας "Q", τότε τέλος ρουτίνας
        JE ADDR2
        CMP AL,30H                      ; Εξετάζουμε αν ο χαρακτήρας είναι ψηφίο
        JL IGNORE                       ; Αν όχι, τον αγνοούμε και διαβάζουμε άλλον
        CMP AL,39H
        JG ADDR1
        PUSH AX
        PRINT AL                        ; τύπωσε το ψηφίο
        POP AX
        SUB AL,30H                      ; εξαγωγή του "καθαρού" αριθμού ('0' = 30Η σε ASCII)
        JMP ADDR2
ADDR1:
        CMP AL,'A'
        JL IGNORE
        CMP AL,'F'
        JG IGNORE
        PUSH AX
        PRINT AL
        POP AX
        SUB AL,37H                      ; μετατροπή του HEX ASCII σε καθαρό αριθμό ('Α' = 41H, 41H-37H = 0AH = 10D)
ADDR2:
        POP DX
        RET
HEX_KEYB ENDP

;------------------------------------------------------------------------------
; ΡΟΥΤΙΝΑ PRINT_DEC
;------------------------------------------------------------------------------

PRINT_DEC PROC NEAR                     ; το δυαδικό βρίσκεται στον BX
    MOV CX,0                            ; μετρητής ψηφίων = 0
    MOV AX, BX
ADDR13:

    MOV DX,0
    MOV BX,10
    DIV BX                              ; διαιρούμε με το 10 (και γι' αυτό μετακινούμε τον αριθμό στον ax)
    PUSH DX                             ; υπόλοιπο (τελευταίο ψηφίο) στην στοίβα
    INC CX
    CMP AX,0                            ; ο αριθμός "τελείωσε"
    JNE ADDR13                          ; αν όχι, τότε συνεχίζουμε να αποθηκεύουμε τα ψηφία του στην στοίβα (οπότε όταν τα ανακτήσουμε να βρίσκονται στην σωστή σειρά)
    ADDR21:
        POP DX
        PRINT_NUM DL                    ; τυπώνουμε τον αριθμό
        LOOP ADDR21
    RET
PRINT_DEC ENDP

;------------------------------------------------------------------------------
;  ΡΟΥΤΙΝΑ PRINT_OCT
;------------------------------------------------------------------------------

PRINT_OCT PROC NEAR
                                        ; το δυαδικό είναι στον BX
    mov cL, 4
    SHL BX, cL
                                        ; τα πρώτα 4 ψηφία πάντα 0 (12bit αριθμός ως είσοδος στον BX), τα αγνοούμε
    mov cx, 4                           ; 4 "ομάδες" των τριών ψηφίων
ADDR14:
    push cx
    mov cl,3
    rol BX, cl
    pop cx
                                        ; #3 MSB σε LSB

    MOV DX, BX
    AND DX, 0007H                       ; μασκάρουμε τα 3 LSB
    PUSH BX
    PUSH CX
    MOV BX, DX
    CALL PRINT_DEC
    POP CX
    POP BX
    LOOP ADDR14
    RET
PRINT_OCT ENDP

;------------------------------------------------------------------------------
; ΡΟΥΤΙΝΑ PRINT_BIN
;------------------------------------------------------------------------------


PRINT_BIN PROC NEAR
    mov cl, 4
    SHL BX, cl
                                        ; τα πρώτα 4 ψηφία πάντα 0, τα αγνοούμε
    mov cx, 12                          ; θέλουμε να τυπώσουμε 12 ψηφία
ADDR12:
    SHL BX, 1
    MOV DL, 0
    ADC DL, 30H
    PRINT DL 
    LOOP ADDR12
    RET
PRINT_BIN ENDP


PRINT_NUM MACRO CHAR
MOV DL, CHAR
ADD DL, 30H
MOV AH,2
INT 21H
ENDM