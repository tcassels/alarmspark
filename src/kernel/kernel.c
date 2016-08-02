// kernel.c

void sleep(int time);
void printk(char *str);
void clear_screen();

void kmain(void) {
	int i = 0; // Kernel loading counter

	clear_screen();
	printk("Kernel Loaded\n");
	printk("hlt\n");
}
