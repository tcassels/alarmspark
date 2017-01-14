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

void sleep(int time);
void printk(char *str);
void clear_screen();

void kmain(void) {
	int i = 0; // Kernel loading counter

	clear_screen();
	sleep(10);
	printk("Kernel Loaded\n");
	printk("Line 2\n");
	printk("Line 3\n");
	printk("Line 4\n");
	printk("Line 5\n");
	printk("Line 6\n");
	printk("Line 7\n");
	printk("Line 8\n");
	printk("Line 9\n");
	printk("Line 10\n");
	printk("Line 11\n");
	printk("Line 12\n");
	printk("Line 13\n");
	printk("Line 14\n");
	printk("Line 15\n");
	printk("Line 16\n");
	printk("Line 17\n");
	printk("Line 18\n");
	printk("Line 19\n");
	printk("Line 20\n");
	printk("Line 21\n");
	printk("Line 22\n");
	sleep(1);
	printk("Line 23\n");
	sleep(1);
	printk("Line 24\n");
	sleep(1);
	printk("Line 25\n");
	sleep(1);
	printk("Line 26\n");
	sleep(1);
	printk("Line 27\n");
	sleep(1);
	printk("Line 28\n");
	sleep(1);
	printk("Line 29\n");
	sleep(1);
	printk("Line 30\n");
	sleep(1);
	printk("hlt\n");
}
