NASM=nasm
LD=ld
COMPILE_32=elf

# LD often has several different linking modes.  This sets the mode
# explicitly, but if you're running on 32-bit Linux LD will use this
# mode by default and the '-m' argument is unnecessary.
LINK_32=elf_i386

default: help

PROGRAMS=hello strlen subroutines includes argv

all: $(PROGRAMS)  ## Build everything at once

%.o: %.s functions.asm
	$(NASM) -f $(COMPILE_32) $<

# Lesson 1 was skipped because it was just Lesson 2 without a proper
# exit handler... and who does that?

hello: hello.o   ## Build Lesson 2: Print string with known length, exit cleanly
	$(LD) -m $(LINK_32) -o $@ $<

strlen: strlen.o  ## Build Lesson 3: Determine length programmatically
	$(LD) -m $(LINK_32) -o $@ $<

subroutines: subroutines.o  ## Build Lesson 4: Separate strlen() and puts() into subroutine.
	$(LD) -m $(LINK_32) -o $@ $<

includes: includes.o ## Build Lesson 5: Separate strlen() and puts() into their own files.
	$(LD) -m $(LINK_32) -o $@ $<

# Lesson 6 is wrapped in Lesson 7: using null-terminated strings, but
# lesson 7 then adds a line feed, so the jump isn't too big.

argv: argv.o  ## Build Lesson 7 and 8: Line feeds and command line arguments
	$(LD) -m $(LINK_32) -o $@ $<

stdin: stdin.o  ## Build Lesson 9: Reading from stdin
	$(LD) -m $(LINK_32) -o $@ $<

help: run-help   ## Print this helpful message (default)

clean:
	rm -f $(PROGRAMS) *.o

include ../makefiles/help.make
