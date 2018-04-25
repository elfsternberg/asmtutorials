    ;; Hello World Program #1
    ;; Compile with: nasm -f elf32 hello.s
    ;; Link with: ld -m elf_i386 -o hello hello.o
    ;; Run with: ./hello

    ;; sys/syscall.h
%define     SYS_write	4
%define     SYS_exit	1

    ;; unistd.h
%define STDOUT		1

section .data
    msg     db  "Hello You Beautiful Human", 0Ah

section .text    
    global _start

_start:
    mov     edx, 26d            ; Length of the message
    mov     ecx, msg            ; Address of the message
    mov     ebx, STDOUT         ; using STDOUT (see definition above)
    mov     eax, SYS_write      ; Using WRITE in 32-bit mode?
    int     80h

    mov     ebx, 0
    mov     eax, SYS_exit
    int     80h
    
    
