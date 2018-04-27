.PHONY: help default

default: help

help:                 ## Print this help message
	@M=$$(perl -ne 'm/^((\w|-)*):.*##/ && print length($$1)."\n"' Makefile | \
		sort -nr | head -1) && \
		perl -ne "m/^((\w|-)*):.*##\s*(.*)/ && print(sprintf(\"%s: %s\t%s\n\", \$$1, \" \"x($$M-length(\$$1)), \$$3))" Makefile

hello32: hello32.s    ## Build the 32 bit version of Project 2
	nasm -f elf hello32.s
	ld -m elf_i386 -o hello32 hello32.o

hello64: hello64.s    ## Build the 32 bit version of Project 2
	nasm -f elf64 hello64.s
	ld -o hello64 hello64.o

counted-hello32: counted-hello32.s    ## Build the 32 bit version of Project 3
	nasm -f elf counted-hello32.s
	ld -m elf_i386 -o counted-hello32 counted-hello32.o

counted-hello64: counted-hello64.s    ## Build the 32 bit version of Project 3
	nasm -f elf64 counted-hello64.s
	ld -o counted-hello64 counted-hello64.o

subroutine-hello32: subroutine-hello32.s    ## Build the 32 bit version of Project 3
	nasm -f elf subroutine-hello32.s
	ld -m elf_i386 -o subroutine-hello32 subroutine-hello32.o

subroutine-hello64: subroutine-hello64.s    ## Build the 32 bit version of Project 3
	nasm -f elf64 subroutine-hello64.s
	ld -o subroutine-hello64 subroutine-hello64.o

clean:                ## Delete all built and intermediate features
	rm -f hello32 hello64 counted-hello32 counted-hello64 *.o
