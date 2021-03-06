/*
*alarmspark - Homebrew kernel in C
*Copyright (C) 2016 Timothy Cassels <cassels2025@gmail.com>
*
*This program is free software; you can redistribute it and/or modify it
*under the terms of the GNU General Public License as published by the Free
*Software Foundation; either version 2 of the License, or (at your option)
*any later version.
*
*This program is distributed in the hope that it will be useful, but
*WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
*or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
*more details.
*
*You should have received a copy of the GNU General Public License along
*with this program; if not, write to the Free Software Foundation, Inc.,
*59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/
#include "strlen.h"

char *vidptr = (char*)0xb8000;
int line = 0; // Used to control which line we're on
int linechar = 0;

void clear_line(int l) {
    for (int c = 0; c < 160; c++) {
        vidptr[(l*160)+(c)] = *" ";
        c++;
    }
}

void terminal_scroll() {
    for (int i = 0; i < 25; i++) {
        for (int m = 0; m < 80; m++) {
            vidptr[i*160+m] = vidptr[(i+1)*160+m];
        }
    }
    //clear_line(25);
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
                linechar = (line*160);
            case '\0':  // Work around so we don't print the very last item
                break;
            default:
                vidptr[linechar] = str[j];
                vidptr[linechar+1] = 0x07;
                linechar = linechar + 2;
        }
    }
}
