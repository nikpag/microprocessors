#include <avr/io.h>

char F0, F1, F, A, B, C, D, dummy;

int main(void) {
	DDRA = 0b11111111;  // Αρχικοποίηση PORTA ως output
	DDRB = 0b00000000; // Αρχικοποίηση PORTB ως input
	
	while (1) {
		A = PINA & 0b00000001;
		
		B = PINA & 0b00000010;
		B = B >> 1;
		
		C = PINA & 0b00000100;
		C = C >> 2;
		
		D = PINA & 0b00001000;
		D = D >> 3;
		
		F0 = ~(A & B & ~C | C & D);
		F0 = F0 & 0b00000001;
		
		F1 = (A | B) & (C | D);
		F1 = F1 << 1;
		
		F = F0 | F1;
		PORTB = F;
		
		dummy = 0; // dummy variable used for breakpoint
	}
	
	return 0;
}