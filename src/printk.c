char *vidptr = (char*)0xb8000;
int line = 0; // Used to control which line we're on
int i = 0;    // Line char position persistence

void terminal_scroll() {
    for (int i = 0; i < 25; ++i) {
        for (int m = 0; m < 80; ++m) {
            vidptr[i*80+m] = vidptr[(i+1)*80+m];
        }
    }
}

void printk(char *str) {
    if (line == 25) {
        terminal_scroll();
    }
    int j = 0; // Specifies which item in the *str char array
    while (str[j] != '\0') {
        switch (str[j]) {
            case '\n':
                /*if (line == 24) {
                    terminal_scroll();
                } else {*/
                    ++line;
                    i = (line*80*2);
                /*}*/
            default:
                vidptr[i] = str[j];
                vidptr[i+1] = 0x07;
                i = i + 2;
                ++j;
        }
    }
}
