START:
  MVI C,08H ; Use C as counter with initial value 8
  LDA 2000H ; Load dip switches content to A
FIRST:
  RAL       ; Rotate left with carry, MSB of A saved at CY
  JC SECOND ; If CY is 1 then light respective LEDs
  DCR C     ; If not, decrement C by 1
  JNZ FIRST ; Repeat until you find a "1"
SECOND:
  MOV A,C   ; Store counter value to A
  CMA       ; Ones' complement due to LED inverse logic
  STA 3000H ; Show appropriate result on LEDs
  JMP START ; Go back to start (continuous function)
END
