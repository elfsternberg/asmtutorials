NASM=nasm
LD=ld
COMPILE_64=elf64

# LD often has several different linking modes.  This sets the mode
# explicitly, but if you're running on 64-bit Linux LD will use this
# mode by default and the '-m' argument is unnecessary.
LINK_64=elf_x86_64

default: help

all: hello strlen subroutines  ## Build everything at once

%.o: %.s
	$(NASM) -f $(COMPILE_64) $<

hello: hello.o   ## Build Lesson 2: Print string with known length, exit cleanly
	$(LD) -m $(LINK_64) -o $@ $<

strlen: strlen.o  ## Build Lesson 2: Determine length programmatically
	$(LD) -m $(LINK_64) -o $@ $<

subroutines: subroutines.o  ## Build Lesson 3: Separate strlen() and puts() into subroutine.
	$(LD) -m $(LINK_64) -o $@ $<

includes: includes.o  ## Build Lesson 4: Separate strlen() and puts() into their own files.
	$(LD) -m $(LINK_64) -o $@ $<

help: run-help   ## Print this helpful message (default)

clean:
	rm -f hello strlen subroutines *.o

include ../makefiles/help.make

