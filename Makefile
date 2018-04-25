

hello32:
	nasm -f elf hello32.s
	ld -m elf_i386 -o hello32 hello32.o

hello64:
	nasm -f elf64 hello64.s
	ld -o hello64 hello64.o

clean:
	rm -f hello32 hello64 *.o
