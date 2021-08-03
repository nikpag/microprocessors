              ; English comments because of Greek encoding issues
  IN 10H
  LXI B,01F4H ; 01F4H = 500 ms delay
  MVI E,01H   ; Set LSB as initial LED
START:
  LDA 2000H   ; Load content of dip switches to A
  MOV D,A     ; Save A to D temporarily
  RRC         ; Slide to right in order to obtain LSB
  JNC START   ; If LSB is 0 then go to start in order to do nothing
  CALL DELB   ; Delay for 500x1ms = 0.5 s
  MOV A,D     ; Retrieve A content
  RLC         ; Slide to left in order to obtain MSB
  JC RIGHT    ; If MSB is 1 then start going to the right
LEFT:         ; This goes to the left (and wraps around)
  MOV A,E     ; E always contains the previous LED configuration
  CMA         ; Inverse LED logic
  STA 3000H   ; Show result on LEDs
  CMA         ; Revert to "normal" logic for arithmetic
  RLC         ; Rotate left
  MOV E,A     ; Store A to E in order to go one bit to the left
  JMP START   ; Repeat until the state changes

RIGHT:        ; This goes to the right (and wraps around)
  MOV A,E     ; This
  CMA         ; is the
  STA 3000H   ; dual of
  CMA         ; moving
  RRC         ; to the
  MOV E,A     ; left
  JMP START   ;
END