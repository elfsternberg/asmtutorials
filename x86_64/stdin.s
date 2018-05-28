    ;; Lesson 9: User Input via STDIN.

%include    "functions.asm"
%define     ILEN    255          ; Amount of space to reserve

    ;; sys/unistd_64.h
%define     SYS_read	0

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
    ;; Again, the challenge with x86_64 is knowing what register to us.
    ;; In this case, RSI - Source Indexing.
    mov     rsi, msg1
    call    puts

    mov     rax, SYS_read       ; General purpose register
    mov     rdi, STDIN          ; Destination Index
    mov     rsi, sinput         ; Source register
    mov     rdx, ILEN           ; Common counter

    ;; And remembering to use 'syscall' instead of interrupt-80
    syscall
    
    mov     rsi, msg2
    call    puts

    mov     rsi, sinput
    call    puts

    call    exit_program
