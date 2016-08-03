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


arch ?= x86_64
kernel := build/alarmspark-$(arch).bin
iso := build/alarmspark-$(arch).iso

linker_script := src/kernel/arch/$(arch)/linker.ld
grub_cfg := src/grub/grub.cfg
assembly_source_files := $(wildcard src/kernel/arch/$(arch)/*.asm)
assembly_object_files := $(patsubst src/kernel/arch/$(arch)/%.asm, \
                                    build/kernel/arch/$(arch)/%.o, \
                                    $(assembly_source_files))

c_source_files := $(wildcard src/kernel/*.c)
c_object_files := $(patsubst src/kernel/%.c, build/kernel/%.o, $(c_source_files))


.PHONY: all clean runk

all: $(kernel)

clean:
	@rm -r build

runk: $(kernel)
	@qemu-system-x86_64 -kernel $(kernel)

runiso: $(iso)
	@qemu-system-x86_64 -cdrom $(iso)

iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
	@mkdir -p build/isofiles/boot/grub
	@cp $(kernel) build/isofiles/boot/alarmspark.bin
	@cp $(grub_cfg) build/isofiles/boot/grub
	@grub-mkrescue -o $(iso) -d /usr/lib/grub/i386-pc build/isofiles

$(kernel): $(assembly_object_files) $(c_object_files) $(linker_script)
	@ld --verbose -n -m elf_i386 -T $(linker_script) -o $(kernel) $(assembly_object_files) $(c_object_files)

build/kernel/arch/$(arch)/%.o: src/kernel/arch/$(arch)/%.asm
	@mkdir -p $(shell dirname $@)
	@nasm -f elf32 $< -o $@

build/kernel/%.o: src/kernel/%.c
	@mkdir -p $(shell dirname $@)
	gcc -v -m32 -c $< -o $@
