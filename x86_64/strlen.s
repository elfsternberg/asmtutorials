    ;; Hello World Program #3
    ;; Compile with: nasm -f elf64 strlen.s
    ;; Link with: ld -o strlen strlen.o
    ;; Run with: ./strlen

    ;; sys/unistd_64.h
%define     SYS_write	1
%define     SYS_exit	60

    ;; unistd.h
%define STDOUT		1

global _start

section .data
    msg     db  "Hello You Beautiful Human, You're Looking Mighty Fine!", 0Ah, 00h


section .text    
_start:
    mov     rsi, msg            ; Move the address of the message into rsi
    mov     rax, rsi            ; Move the address of the message into rax
                                ; (Register-to-register copying is faster that a constant!) 

nextchar:
    cmp     byte [rax], 0       ; Compare the byte pointed to by rax with zero
    

    ;; Small detail: cmp and sub use the same internal architecture,
    ;; except cmp doesn't copy the results into the first operand and
    ;; sub does.  cmp sets flags; does sub?  This is why 'jz' works,
    ;; because if they're equal the result of subtraction is zero.
    jz      counted             ; Jump if the zero flag set
    inc     rax                 ; Increment rax by 1
    jmp     nextchar            ; Jump to the beginning of the loop

counted:    
    sub     rax, rsi            ; Substract source from endpointer, leaving counter
    mov     rdx, rax            ; Length of the message
    mov     rsi, msg            ; Address of the message
    mov     rdi, STDOUT         ; using STDOUT (see definition above)
    mov     rax, SYS_write      ; Using WRITE in 64-bin mode.
    syscall                     ; Call the kernel

    mov     rdi, 0
    mov     rax, SYS_exit
    syscall
    
