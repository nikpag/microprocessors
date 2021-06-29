


DATA SEGMENT
S DB 20 DUP(?)
DATA ENDS



CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

PRINT MACRO CHAR
    PUSH AX
    PUSH DX                     ; αποθηκεύουμε τιμές των καταχωρητών που θα αλλάξουν αργότερα
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
    MOV BL,10                   ; Κωδικός ASCII για την αλλαγή γραμμής
    PRINT BL
    POP BX
ENDM

MAIN PROC FAR

  REPEAT:
    MOV CX,0                    ; διαβάζουμε το πολύ 20 φορές
    MOV DI,0

  READ:
    CALL INPUT
    CMP AL,13
    JE BEGIN
    MOV S[DI],AL                ; αποθηκεύουμε την είσοδο (AL)
    INC DI                      ; αυξάνουμε τον DI για να διαβάσουμε και να αποθηκεύσουμε τον επόμενο αριθμό
    INC CX                      ; αυξάνουμε τον μετρητή δεδομένων
    CMP CX,20                   ; αν έχουμε διαβάσει 20 φορές τότε σταματάμε να διαβάζουμε
    JB READ                     ; επαναλαμβάνουμε μέχρι να τελειώσει το διάβασμα



  BEGIN:
    MOV DI,0
    MOV DX,CX                   ; αποθηκεύουμε τον μετρητή δεδομένων
    NEWLINE
  LETTERS:
    MOV AL,S[DI]
    CMP AL,97
    JB SKIP2
    CMP AL,122
    JA SKIP2
    SUB AL,32                   ; μετατροπή σε ΚΕΦΑΛΑΙΑ
    PRINT AL                    ; αν είναι γράμμα, το τυπώνουμε
  SKIP2:
    INC DI
    LOOP LETTERS
    PRINT "-"
    MOV CX,DX
    MOV DI,0

  NUMBERS:
    MOV AL,S[DI]
    CMP AL,48
    JB SKIP
    CMP AL,57
    JA SKIP
    PRINT AL                    ; αν είναι αριθμός, τον τυπώνουμε
  SKIP:
    INC DI
    LOOP NUMBERS
    NEWLINE
    JMP REPEAT
MAIN ENDP

INPUT PROC NEAR
  IGNORE:
    MOV AH,8
    INT 21H                     ; διαβάζουμε από το πληκτρολόγιο, το αποτέλεσμα μπαίνει στον AL
    CMP AL,61                   ; ελέγχουμε για ισότητα
    JE QUIT                     ; αν ισχύει η ισότητα, τότε κάνουμε quit
    CMP AL,13                   ; έλεγχος για την περίπτωση που θα πατήσουμε enter
    JE  ENTER
    CMP AL,48                   ; αν δεν έχουμε a-z (δηλ. 97-122) ή 0-9 (δηλ. 48-57) τότε το αγνοούμε
    JB IGNORE
    CMP AL,122
    JA IGNORE
    CMP AL,57
    JBE FINISH
    CMP AL,97
    JB IGNORE
  FINISH:
    PRINT AL
    RET
  ENTER:
    RET
  QUIT:
    MOV AX,4C00H                ; τέλος
    INT 21H    
INPUT ENDP

CODE ENDS
END MAIN