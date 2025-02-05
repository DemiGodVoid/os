CC=i686-linux-gnu-gcc
LD=i686-linux-gnu-ld
NASM=nasm
CFLAGS=-ffreestanding -nostdlib -m32

all: os-image.bin

boot.o: boot.asm
	$(NASM) -f bin boot.asm -o boot.o

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

kernel.bin: kernel.o
	$(LD) -T linker.ld -o kernel.bin kernel.o

os-image.bin: boot.o kernel.bin
	cat boot.o kernel.bin > os-image.bin

run:
	qemu-system-x86_64 -drive format=raw,file=os-image.bin

clean:
	rm -f *.o *.bin
