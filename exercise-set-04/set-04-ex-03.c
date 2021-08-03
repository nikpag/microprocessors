#include <avr/io.h>

char x, dummy;

int main(void) {

	DDRA = 0b11111111; // Initialize PORTA as output
	DDRC = 0b00000000; // Initialize PORTC as input

	x = 0b00000001;	// Initialize variable for LED initially ON

	PORTA = x;

	while(1) {
		if ((PINC & 0b0001) == 0b0001) { // check if push-button SW0 is pressed

			while ((PINC & 0b0001) == 0b0001); // check if push-button SW0 is released

			// SW0: Shift-rotation of led one position to the left (circular)

			if (x == 0b10000000)
			x = 0b00000001;
			else
			x = x << 1;
		}

		if ((PINC & 0b0010) == 0b0010) { // check if push-button SW1 is pressed

			while ((PINC & 0b0010) == 0b0010); // check if push-button SW1 is released

			// SW0: Shift-rotation of led one position to the right (circular)

			if (x == 0b00000001)
			x = 0b10000000;
			else
			x = x >> 1;
		}

		if ((PINC & 0b0100) == 0b0100) { // check if push-button SW2 is pressed

			while ((PINC & 0b0100) == 0b0100); // check if push-button SW2 is released

			// SW2: Move led to MSB place (led7)

			x = 0b10000000;
		}

		if ((PINC & 0b1000) == 0b1000) { // check if push-button SW3 is pressed

			while ((PINC & 0b1000) == 0b1000); // check if push-button SW3 is released

			// SW3: Move led to initial (LSB) place (led0)

			x = 0b00000001;
		}

		PORTA = x; // show output to PORTA
		dummy = 0;
	}

	return 0;
}
