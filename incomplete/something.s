;; Pure assembly, library-free Linux threading demo
bits 32
global _start

;; sys/syscall.h
%define SYS_write	1
%define SYS_exit	60

;; unistd.h
%define STDOUT		1

section .data
hello:	db `Goodbye\n`
    
section .text
_start:
    mov esi, hello
    mov edx, 8d
    mov edi, STDOUT
    mov eax, SYS_write
    syscall

	mov edi, 0                  ; Success!
	mov eax, SYS_exit           ; Do it!
	syscall
