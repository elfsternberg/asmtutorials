NASM=nasm
LD=ld
COMPILE_32=elf

# LD often has several different linking modes.  This sets the mode
# explicitly, but if you're running on 32-bit Linux LD will use this
# mode by default and the '-m' argument is unnecessary.
LINK_32=elf_i386

default: help

all: hello strlen subroutines  ## Build everything at once

%.o: %.s
	$(NASM) -f $(COMPILE_32) $<

hello: hello.o   ## Build Lesson 2: Print string with known length, exit cleanly
	$(LD) -m $(LINK_32) -o $@ $<

strlen: strlen.o  ## Build Lesson 2: Determine length programmatically
	$(LD) -m $(LINK_32) -o $@ $<

subroutines: subroutines.o  ## Build Lesson 3: Separate strlen() and puts() into subroutine.
	$(LD) -m $(LINK_32) -o $@ $<

help: run-help   ## Print this helpful message (default)

clean:
	rm -f hello strlen subroutines *.o

include ../makefiles/help.make
