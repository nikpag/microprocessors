INCLUDE macros.asm

DATA SEGMENT
    MSGZ DB "Z=$"
    MSGW DB "W=$"
    MSGSUM DB "Z+W=$"
    MSGSUB DB "Z-W=$"
    MSGMINUS DB "Z-W=-$"
    Z DB 0
    W DB 0
        TEN DB DUP(10)
DATA ENDS

CODE SEGMENT
        ASSUME CS:CODE, DS:DATA

        MAIN PROC FAR
                        MOV AX,DATA
                        MOV DS,AX

                START:
                        PRINTSTR MSGZ
                        CALL READ_DEC_DIGIT     ; διαβάζουμε το πρώτο στοιχείο του Ζ
                        MUL TEN                 ; πολλαπλασιάζουμε τον αριθμό των δεκάδων με 10
                        LEA DI,Z
                        MOV [DI],AL             ; αποθηκεύουμε τον αριθμό_δεκάδων*10 του Ζ
                        CALL READ_DEC_DIGIT     ; διαβάζουμε το δεύτερο ψηφίο
                        ADD [DI],AL             ; προσθέτουμε το δεύτερο ψηφίο στον αριθμό_δεκάδων*10 και έτσι έχουμε τον αριθμό Ζ αποθηκευμένο σωστά

                        PRINTCH ' '

                        PRINTSTR MSGW
                        CALL READ_DEC_DIGIT     ; διαβάζουμε το πρώτο ψηφίο του W
                        MUL TEN                 ; πολλαπλασιάζουμε τον αριθμό των δεκάδων με 10
                        LEA DI,W
                        MOV [DI],AL             ; αποθηκεύουμε τον αριθμό_δεκάδων*10 του W
                        CALL READ_DEC_DIGIT     ; διαβάζουμε το δεύτερο ψηφίο του W
                        ADD [DI],AL             ; προσθέτουμε το δεύτερο ψηφίο στον αριθμό_δεκάδων*10 και έτσι έχουμε τον αριθμό W αποθηκευμένο σωστά

                        PRINTLN

                        MOV AL,[DI]             ; ο AL κρατάει τον W
                        LEA DI,Z                ; ο DI έχει την διεύθυνση του Z
                        ADD AL,[DI]             ; Z + W
                        PRINTSTR MSGSUM
                        CALL PRINT_NUM8_HEX     ; τυπώνουμε το άθροισμα

                        PRINTCH ' '

                        MOV AL,[DI]             ; ο AL κρατάει τον Z
                        LEA DI,W                ; ο DI έχει την διεύθυνση του W
                        MOV BL,[DI]             ; ο BL κρατάει τον W

                        CMP AL,BL               ; ελέγχουμε αν AL < BL
                        JB MINUS                ; αν AL < BL τότε το Z - W θα είναι αρνητικός αριθμός
                        SUB AL,BL               ; αλλιώς απλά κάνουμε την αφαίρεση και τυπώνουμε
                        PRINTSTR MSGSUB         ; χωρίς "-" μπροστά
                        JMP SHOWSUB
                MINUS:
                        SUB BL,AL               ; αν η διαφορά είναι αρνητικός αριθμός τότε την μετατρέπουμε σε θετικό
                        MOV AL,BL
                        PRINTSTR MSGMINUS       ; και τυπώνουμε μπροστά το σύμβολο "-"
                SHOWSUB:
                        CALL PRINT_NUM8_HEX     ; τυπώνουμε την διαφορά
                        PRINTLN
                        PRINTLN
                        JMP START               ; επαναλαμβάνουμε
        MAIN ENDP

        READ_DEC_DIGIT PROC NEAR
                READ:
                        READCH                  ; μακροεντολή για το διάβασμα
                        CMP AL,48               ; ελέγχουμε αν είναι δεκαδικό ψηφίο (48-57)
                        JB READ
                        CMP AL,57
                        JA READ
                        PRINTCH AL              ; τυπώνουμε το ψηφίο
                        SUB AL,48               ; αφαιρούμε το 48 προκειμένου να κρατήσουμε τον αριθμό δεκάδων
                        RET
        READ_DEC_DIGIT ENDP

        PRINT_NUM8_HEX PROC NEAR
                        MOV DL,AL
                        AND DL,0F0H             ; πρώτο δεκαεξαδικό ψηφίο
                        MOV CL,4
                        ROR DL,CL               ; ολισθαίνουμε τα 4 MSB 4 φορές δεξιά
                        CMP DL,0                ; αν το πρώτο ψηφίο είναι 0 (άρα τα 4 MSB) τότε το αγνοούμε
                        JE SKIPZERO
                        CALL PRINT_HEX
                SKIPZERO:
                        MOV DL,AL
                        AND DL,0FH              ; δεύτερο δεκαεξαδικό ψηφίο
                        CALL PRINT_HEX
                        RET
        PRINT_NUM8_HEX ENDP

        PRINT_HEX PROC NEAR
                        CMP DL,9                ; αν το ψηφίο είναι μεγαλύτερο του 9 τότε προσθέτουμε το 55 για να φτάσουμε στο A-F (65-70 σε ASCII)
                        JG LETTER               ; αν είναι μεγαλύτερο τότε πηγαίνουμε στο letter που προσθέτει 55
                        ADD DL,48               ; αν το ψηφίο είναι <= 9 τότε προσθέτουμε 48 για να φτάσουμε στο 48-57 (0-9)
                        JMP SHOW                ; πηγαίνουμε στο show (που κάνει print το ψηφίο)
                LETTER:
                        ADD DL,55
                SHOW:
                        PRINTCH DL
                        RET
        PRINT_HEX ENDP
CODE ENDS
END MAIN
