// kernel.c

void sleep(int time);
void printk(char *str);
void clear_screen();

void kmain(void) {
	int i = 0; // Kernel loading counter

	clear_screen();
	printk("Loading Kernel.....Standby\n");
	for (i=0; i<10; ++i) {
		sleep(1);
		printk("..");
	}
	printk("Kernel Loaded, begin driver init\n");
	printk("Driver init failed, no drivers dummy\n");
}
