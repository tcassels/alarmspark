; kernel.asm

global start
extern kmain                 ; kmain is defined in the c file

bits 32
section .text

	; multiboot spec
	align 4
	dd 0x1BADB002            ; magic number
	dd 0x00                  ; flags
	dd - (0x1BADB002 + 0x00) ; checksum

start:
	cli                      ; block interrupts
	mov esp, stack_space     ; set stack pointer
	call kmain               ; Call our C code
	hlt                      ; halt the cpu

section .bss
resb 8192                    ; 8KB for stack
stack_space:
