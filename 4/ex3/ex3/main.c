#include <avr/io.h>

char x, dummy;

int main(void) {

	DDRA = 0b11111111; // Αρχικοποίηση του PORTA ως output
	DDRC = 0b00000000; // Αρχικοποίηση του PORTC ως input

	x = 0b00000001;	// Αρχικοποίηση μεταβλητής για αρχικά αναμμένο LED

	PORTA = x;

	while(1) {
		if ((PINC & 0b0001) == 0b0001) { // Έλεγχος πατήματος push-button SW0

			while ((PINC & 0b0001) == 0b0001); // Έλεγχος επαναφοράς push-button SW0

			// SW0: Ολίσθηση-περιστροφή του led μία θέση αριστερά (κυκλικά)
			
			if (x == 0b10000000)
			x = 0b00000001;
			else
			x = x << 1;
		}

		if ((PINC & 0b0010) == 0b0010) { // Έλεγχος πατήματος push-button SW1

			while ((PINC & 0b0010) == 0b0010); // Έλεγχος επαναφοράς push-button SW1

			// SW1: Ολίσθηση-περιστροφή του led μία θέση δεξιά (κυκλικά)
			
			if (x == 0b00000001)
			x = 0b10000000;
			else
			x = x >> 1;
		}

		if ((PINC & 0b0100) == 0b0100) { // Έλεγχος πατήματος push-button SW2

			while ((PINC & 0b0100) == 0b0100); // Έλεγχος επαναφοράς push-button SW2

			// SW2: Μετακίνηση του αναμμένου led στην θέση MSB (led7)
			
			x = 0b10000000;
		}

		if ((PINC & 0b1000) == 0b1000) { // Έλεγχος πατήματος push-button SW3

			while ((PINC & 0b1000) == 0b1000); // Έλεγχος επαναφοράς push-button SW3
			
			// SW3: Μετακίνηση του αναμμένου led στην αρχική του θέση LSB (led0)
			
			x = 0b00000001;
		}

		PORTA = x; // Έξοδος σε PORTA
		dummy = 0;
	}

	return 0;
}