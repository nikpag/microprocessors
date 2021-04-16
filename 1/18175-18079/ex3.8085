              ; English comments because of Greek encoding issues
  LXI B,01F4H ; 01F4H = 500 ms delay
START:
  LDA 2000H
  CPI 64H     ; Compare with 100
  JNC 100     ; If A > 100, then go to "100"
  MVI D,FFH   ;
DECA:
  INR D       ;
  SUI 0AH     ; Continuous subtraction of 10
  JNC DECA    ; If it is positive, continue
  ADI 0AH     ; Correct negative remainder
  MOV E,A     ; Ones
  MOV A,D     ; Tens
  RLC         ; Shift 4 times to the left
  RLC         ;
  RLC         ;
  RLC         ;
  ADD E       ; Add the ones
  CMA         ; Inverse LED Logic
  STA 3000H
  JMP START
100:
  CPI C8H     ; Compare with 200
  JNC 200     ; If A > 200, then go to "200"
  MVI A,F0H   ; 4 LSB LEDs ON (Inverse Logic)
  STA 3000H
  CALL DELB   ; Delay
  MVI A,FFH   ; 4 LSB LEDs OFF
  STA 3000H
  CALL DELB
  JMP START
200:
  MVI A,0FH   ; 4 MSB LEDs ON (Inverse Logic)
  STA 3000H
  CALL DELB   ; Delay
  MVI A,FFH   ; 4 MSB LEDs OFF
  STA 3000H
  CALL DELB   ; Delay
  JMP START
END