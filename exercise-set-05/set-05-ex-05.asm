INCLUDE macros.asm

DATA SEGMENT
        STARTPROMPT DB "START(Y,N):$"                   ; αρχικό μήνυμα
        ERRORMSG DB "ERROR$"                            ; μήνυμα σφάλματος
DATA ENDS

CODE SEGMENT
        ASSUME CS:CODE, DS:DATA

        MAIN PROC FAR
                        MOV AX,DATA
                        MOV DS,AX

                        PRINTSTR STARTPROMPT
                START:                                  ; διαβάζουμε τον πρώτο χαρακτήρα
                        READCH
                        CMP AL,'N'                      ; ελέγχουμε αν είναι ίσος με "Ν"
                        JE FINISH                       ; αν ναι, τέλος
                        CMP AL,'Y'                      ; ελέγχουμε αν είναι ίσος με "Y"
                        JE CONT                         ; αν ναι, συνεχίζουμε
                        JMP START
                CONT:
                        PRINTCH AL                      ; τυπώνουμε τον πρώτο χαρακτήρα
                        PRINTLN
                        PRINTLN
                NEWTEMP:
                        MOV DX,0
                        MOV CX,3                        ; διαβάζουμε 3 ψηφία
                READTEMP:                               ; παίρνουμε είσοδο
                        CALL HEX_KEYB
                        CMP AL,'N'                      ; ελέγχουμε αν ισχύει η συνθήκη τερματισμού
                        JE FINISH
                                                        ; βάζουμε όλα τα ψηφία στον DX
                        PUSH CX
                        DEC CL
                        ROL CL,2
                        MOV AH,0
                        ROL AX,CL
                        OR DX,AX
                        POP CX
                        LOOP READTEMP

                        PRINTTAB
                        MOV AX,DX
                        CMP AX,2047                     ; ελέγχουμε αν V <= 2
                        JBE BRANCH1
                        CMP AX,3071                     ; ελέγχουμε αν V <= 3
                        JBE BRANCH2
                        PRINTSTR ERRORMSG               ; ελέγχουμε αν V > 3
                        PRINTLN
                        JMP NEWTEMP

                BRANCH1:                                ; πρώτη περίπτωση (V <= 2), T = (800 * V) div 4095
                        MOV BX,800
                        MUL BX
                        MOV BX,4095
                        DIV BX
                        JMP SHOWTEMP
                BRANCH2:                                ; δεύτερη περίπτωση (2 < V <= 3), T = ((3200 * V) div 4095) - 1200
                        MOV BX,3200
                        MUL BX
                        MOV BX,4095
                        DIV BX
                        SUB AX,1200
                SHOWTEMP:
                        CALL PRINT_DEC16                ; ακέραιο μέρος (AX)
                                                        ; κλασματικό μέρος = (υπόλοιπο * 10) div 4095
                        MOV AX,DX
                        MOV BX,10
                        MUL BX
                        MOV BX,4095
                        DIV BX

                        PRINTCH ','
                        ADD AL,48                       ; ASCII
                        PRINTCH AL                      ; τυπώνουμε το κλασματικό μέρος
                        PRINTLN
                        JMP NEWTEMP

                FINISH:
                        PRINTCH AL
                        EXIT
        MAIN ENDP
                                                        ; βάζουμε το δεκαεξαδικό ψηφίο στον AL
        HEX_KEYB PROC NEAR
                READ:
                        READCH
                        CMP AL,'N'                      ; ελέγχουμε για ισότητα με "Ν"
                        JE RETURN
                        CMP AL,48                       ; ελέγχουμε αν < 0
                        JL READ
                        CMP AL,57                       ; ελέγχουμε αν > 9
                        JG LETTER
                        PRINTCH AL
                        SUB AL,48                       ; ASCII
                        JMP RETURN
                LETTER:                                 ; A-F
                        CMP AL,'A'                      ; ελέγχουμε αν < Α
                        JL READ
                        CMP AL,'F'                      ; ελέγχουμε αν > F
                        JG READ
                        PRINTCH AL
                        SUB AL,55                       ; ASCII
                RETURN:

                        RET
        HEX_KEYB ENDP
                                                        ; τυπώνουμε τον 16bit δεκαδικό αριθμό από τον AX
        PRINT_DEC16 PROC NEAR
                        PUSH DX

                        MOV BX,10
                        MOV CX,0                        ; μετρητής ψηφίων
                GETDEC:                                 ; παίρνουμε τα ψηφία
                        MOV DX,0                        ; mod 10 για υπόλοιπο
                        DIV BX                          ; div 10
                        PUSH DX
                        INC CL
                        CMP AX,0                        ; ελέγχουμε αν το πηλίκο είναι ίσο με 0
                        JNE GETDEC
                PRINTDEC:                               ; τυπώνουμε τα ψηφία
                        POP DX
                        ADD DL,48                       ; ASCII
                        PRINTCH DL
                        LOOP PRINTDEC

                        POP DX
                        RET
        PRINT_DEC16 ENDP
CODE ENDS
END MAIN
