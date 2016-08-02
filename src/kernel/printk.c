char *vidptr = (char*)0xb8000;
int line = 0; // Used to control which line we're on
int linechar = 0;

void clear_line(int l) {
    for (int c = 0; c < 80; c++) {
        vidptr[l*80*2+c] = " ";
        c++;
    }
}

void terminal_scroll() {
    for (int i = 0; i < 25; i++) {
        for (int m = 0; m < 80; m++) {
            vidptr[i*80*2+m] = vidptr[(i+1)*80*2+m];
        }
    }
    clear_line(25);
}

void printk(char *str) {
    int j = 0; // Specifies which item in the *str char array
    int len = strlen(str);
    for (j = 0; j < len; j++) {
        switch (str[j]) {
            case '\n':  // New line char = new line :)
                if (line <= 23) {
                    line++;
                } else {
                    terminal_scroll();
                }
                linechar = (line*80*2);
            case '\0':  // Work around so we don't print the very last item
                break;
            default:
                vidptr[linechar] = str[j];
                vidptr[linechar+1] = 0x07;
                linechar = linechar + 2;
        }
    }
}
