// kernel.c

void sleep(int time);
void printk(char *str);
void clear_screen();

void kmain(void) {
	clear_screen();
	printk("Loading Kernel.....Standby");
	sleep(1);
	printk("Kernel Loaded, begin driver init");
	sleep(10);
	printk("Driver init failed, no drivers dummy");
}
