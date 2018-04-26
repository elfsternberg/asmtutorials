    ;; Hello World Program #1
    ;; Compile with: nasm -f elf hello.s
    ;; Link with: ld -m elf_i386 -o hello hello.o
    ;; Run with: ./hello

    ;; sys/unistd_32.h
%define     SYS_write	4
%define     SYS_exit	1

    ;; unistd.h
%define STDOUT		1

section .data
    msg     db  "Hello You Beautiful Human, You're Looking Fine Today!", 0Ah, 00h
    
section .text    
    global _start

_start:
    mov     ebx, msg            ; Move the address of the message into ebx
    mov     eax, ebx            ; Move the address of the message into eax (Register-to-register copying is faster that a constant!)

nextchar:
    cmp     byte [eax], 0       ; Compare the byte pointed to by eax with zero.

    ;; Small detail: cmp and sub use the same internal architecture,
    ;; except cmp doesn't copy the results into the first operand and
    ;; sub does.  cmp sets flags; does sub?  This is why 'jz' works,
    ;; because if they're equal the result of subtraction is zero.
    jz      counted        ; Jump if the zero flag set
    inc     eax
    jmp     nextchar

counted:
    sub     eax, ebx            ; Subtract the end from the start, and the result goes into the start

    mov     edx, eax            ; syswrite needs that register for something else! Man, picking registers is hard.
    mov     ecx, msg            ; Address of the message (not the content)
    mov     ebx, STDOUT         ; using STDOUT (see definition above)
    mov     eax, SYS_write      ; Using WRITE in 32-bit mode?
    int     80h                 ; Interrupt target. The 'h' means 'hexidecimal'

    mov     ebx, 0
    mov     eax, SYS_exit
    int     80h 
    
    
