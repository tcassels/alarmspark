void clear_screen() {
	char *vidptr = (char*)0xb8000;
	unsigned int j = 0;
		while (j < 80 * 25 * 2) {
			vidptr[j] = ' '; // Write blank char
			vidptr[j+1] = 0x07; //light grey on black screen
			j = j + 2;
        }
}
