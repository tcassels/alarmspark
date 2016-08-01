char *vidptr = (char*)0xb8000;
int line = 0;
void printk(char *str) {
    unsigned int j = 0; // Rep char array element
    unsigned int i = (line*80*2);
    while (str[j] != '\0') {
        vidptr[i] = str[j];
        vidptr[i+1] = 0x07;
        ++j;
        i = i + 2;
    }
    ++line;
}