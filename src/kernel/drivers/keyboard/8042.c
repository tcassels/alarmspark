/*
PS2 Keyboard Driver
*/

#include "../../functions/sleep.h"
#include "../../functions/printk.h"
#include "../io.h"


char *keyboard = (char*)0x60;

void identify_ps2()
{
    printk("Starting PS2 ident\n");
    char res;
    res = inb(0x60);
    char hex;
    if (res) {
        hex = res + '0';
        printk(res);
    } else {
        printk("PS2 ident failed\n");
    }
    printk("PS2 ident done\n");
}
