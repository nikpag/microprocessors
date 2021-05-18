#include <avr/io.h>

char x;

int main(void)
{
	DDRB=0xFF;							// Αρχικοποίηση PORTB ως output
	DDRA=0x00;							// Αρχικοποίηση PORTA ως input

	x = 1;								// Αρχικοποίηση μεταβλητής για αρχικά αναμμένο LED

	while(1)
	{
		if ((PINA & 0x01) == 0x01) {	// Έλεγχος πατήματος push-button SW0

			while ((PINA & 0x01) == 1); // Έλεγχος επαναφοράς push-button SW0

			if (x==128)					// Έλεγχος υπερχείλισης
			x = 1;
			else
			x = x << 1;					// Ολίσθηση αριστερά
		}

		PORTB = x;						// Έξοδος σε PORTB
	}

	return 0;
}