#alarmspark - Homebrew kernel in C
#Copyright (C) 2016 Timothy Cassels <cassels2025@gmail.com>
#
#This program is free software; you can redistribute it and/or modify it
#under the terms of the GNU General Public License as published by the Free
#Software Foundation; either version 2 of the License, or (at your option)
#any later version.
#
#This program is distributed in the hope that it will be useful, but
#WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
#or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
#more details.
#
#You should have received a copy of the GNU General Public License along
#with this program; if not, write to the Free Software Foundation, Inc.,
#59 Temple Place, Suite 330, Boston, MA 02111-1307 USA


NAME := alarmspark
VER := 0.0.0
ARCH := i386
BINTARGET := bin/$(NAME)-$(VER)-$(ARCH).bin
ISOTARGET := bin/$(NAME)-$(VER)-$(ARCH).iso
CC := gcc
CFLAGS :=
LIB :=
INC :=
linker_script := src/kernel/arch/$(ARCH)/linker.ld
grub_cfg := src/grub/grub.cfg

SRCDIR := src
BUILDDIR := build
BINDIR := bin
obj-y :=

include $(SRCDIR)/kernel/Makefile

obj := $(patsubst src/%.c,build/%.o,$(obj-y))

runk: $(BINTARGET)
	@qemu-system-x86_64 -kernel $(BINTARGET)

runiso: $(ISOTARGET)
	@qemu-system-x86_64 -cdrom $(ISOTARGET)

iso: $(ISOTARGET)

$(ISOTARGET): $(BINTARGET) $(grub_cfg)
	@mkdir -p build/isofiles/boot/grub
	@cp $(BINTARGET) build/isofiles/boot/alarmspark.bin
	@cp $(grub_cfg) build/isofiles/boot/grub
	@grub-mkrescue -o $(ISOTARGET) -d /usr/lib/grub/i386-pc build/isofiles

clean:
	rm -R $(BUILDDIR) $(BINDIR)

$(BINTARGET): $(obj) build/kernel/arch/$(ARCH)/kernel.o
	@echo $(asmobj)
	@mkdir -p $(BINDIR)
	@echo " Linking..."
	@ld -n -m elf_i386 -T $(linker_script) -o $(BINTARGET) build/kernel/arch/$(ARCH)/kernel.o $(obj)

build/kernel/arch/$(ARCH)/kernel.o: src/kernel/arch/$(ARCH)/kernel.asm
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(@D)
	@nasm -f elf32 -o build/kernel/arch/$(ARCH)/kernel.o src/kernel/arch/$(ARCH)/kernel.asm

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $(INC) -c -m32 -o $@ $<
