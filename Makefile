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
