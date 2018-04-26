
help:                 ## Print this help message
	@M=$$(perl -ne 'm/^((\w|-)*):.*##/ && print length($$1)."\n"' Makefile | \
		sort -nr | head -1) && \
		perl -ne "m/^((\w|-)*):.*##\s*(.*)/ && print(sprintf(\"%s: %s\t%s\n\", \$$1, \" \"x($$M-length(\$$1)), \$$3))" Makefile

hello32: hello32.s    ## Build the 32 bit version of Project 1
	nasm -f elf hello32.s
	ld -m elf_i386 -o hello32 hello32.o

hello64: hello64.s    ## Build the 32 bit version of Project 1
	nasm -f elf64 hello64.s
	ld -o hello64 hello64.o

hello-strlen32: hello-strlen32.s    ## Build the 32 bit version of Project 1
	nasm -f elf hello-strlen32.s
	ld -m elf_i386 -o hello-strlen32 hello-strlen32.o

hello-strlen64: hello-strlen64.s    ## Build the 32 bit version of Project 1
	nasm -f elf64 hello-strlen64.s
	ld -o hello-strlen64 hello-strlen64.o

clean:                ## Delete all built and intermediate features
	rm -f hello32 hello64 hello-strlen32 hello-strlen64 *.o
