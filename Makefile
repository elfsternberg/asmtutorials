.PHONY: help default

default: help

help:                 ## Print this help message
	@M=$$(perl -ne 'm/^((\w|-)*):.*##/ && print length($$1)."\n"' Makefile | \
		sort -nr | head -1) && \
		perl -ne "m/^((\w|-)*):.*##\s*(.*)/ && print(sprintf(\"%s: %s\t%s\n\", \$$1, \" \"x($$M-length(\$$1)), \$$3))" Makefile

all:				## Make everything in all trees
	cd x86 && make all
	cd x86_64 && make all

clean:                ## Delete all built and intermediate features
	cd x86 && make clean
	cd x86_64 && make clean

include ./makefiles/help.make
