    ;; Lesson 9: User Input via STDIN.

%include    "functions.asm"
%define     ILEN    255          ; Amount of space to reserve

    ;; sys/unistd_32.h
%define     SYS_read	3

    ;; unistd.h
%define STDIN		0

    
section .data
    msg1    db  "Please enter your name: ", 0h
    msg2    db  "Hello, ", 0h

section .bss
    sinput  resb    ILEN         ; Reserve 255 bytes of space.  The space has no guarantees that I know of.

section .text
    global _start

_start:
    mov     eax, msg1
    call    putslf

    mov     edx, ILEN
    mov     ecx, sinput
    mov     ebx, STDIN
    mov     eax, SYS_read
    int     80h

    mov     eax, msg2
    call    puts

    mov     eax, sinput
    call    puts                ; By default, sinput keeps the LF terminator!

    call    exit_program
    
    

    

    
