#include <avr/io.h>

char A, B, C, D, F0, F1, OUT, dummy;
int main (void) {
	DDRA = 0x00 ; 											// initialize PINA as input
	DDRB = 0xFF ; 											// initialize PORTB as output

	while (1) {
		A = PINA & 0x01 ; 								// LSB (1st bit)
		B = PINA & 0x02 ; 								// 2nd bit
		C = PINA & 0x04 ; 								// 3rd bit
		D = PINA & 0x08 ; 								// 4th bit
		B = B >> 1; 											//shifting right
		C = C >> 2; 											// shifting right
		D = D >> 3; 											// shifting right, all bits are in the 1st place (LSB)
		F0 = ~((A & B & (~C)) | (C & D)); // expression 1
		F0 = F0 & 0x01;

		F1 = ( (A | B) & (C | D) ) ; 			// expression 2
		F1 = F1 << 1; 										// shift left, F1 is in the 2nd bit place, where 1st place = LSB place
		OUT = F0 | F1;
		PORTB = OUT;
		dummy = 0;
	}
	return 0;
}
