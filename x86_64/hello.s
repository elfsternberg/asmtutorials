    ;; Hello World Program #1
    ;; Compile with: nasm -f elf64 hello.s
    ;; Link with: ld -o hello hello.o
    ;; Run with: ./hello

    ;; sys/unistd_64.h
%define     SYS_write	1
%define     SYS_exit	60

    ;; unistd.h
%define STDOUT		1

section .data
    msg     db  "Hello You Beautiful Human", 0Ah
    len     equ $-msg           ; NASM-supplied macro

section .text    
    global _start

_start:
    mov     rdx, len            ; Length of the message
    mov     rsi, msg            ; Address of the message
    mov     rdi, STDOUT         ; using STDOUT (see definition above)
    mov     rax, SYS_write      ; Using WRITE in 32-bit mode?
    syscall

    mov     rdi, 0
    mov     rax, SYS_exit
    syscall
    
