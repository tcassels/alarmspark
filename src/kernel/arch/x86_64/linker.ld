OUTPUT_FORMAT(elf32-i386)
ENTRY(START)
SECTIONS {
	. = 1M;
	.text : { *(.text) }
	.data : { *(.data) }
	.bss  : { *(.bss) }
}
