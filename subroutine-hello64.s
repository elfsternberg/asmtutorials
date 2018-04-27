    ;; Hello World Program #1
    ;; Compile with: nasm -f elf hello.s
    ;; Link with: ld -m elf_i386 -o hello hello.o
    ;; Run with: ./hello

    ;; sys/unistd_32.h
%define     SYS_write	1
%define     SYS_exit	60

    ;; unistd.h
%define STDOUT		1

section .data
    msg     db  "Okay, so we're doing 64-bit subroutines now, huh?", 0Ah, 00h

section .text
    global _start

_start:
    mov     rsi, msg            ; Put the address of our message into rax.
    call    strlen              ; call the function strlen.  We're using RAX as our argument.
    ;; At this point, RDX is length and RSI still points to the source.
    ;; The differences here make me wonder if my understanding of the 32-bit
    ;; version are incorrect, since now the two fields that matter are
    ;; already populated.
    ;; 
    ;; Note that this is non-standard.  RAX is usually assumed to hold
    ;; the return value, but I'm cheating by knowing that printit
    ;; wants the result of strlen in RDX.  Whether this is exploitable
    ;; in a compiler (you know, that whole "choosing registers"
    ;; question) is something to ponder.
    
    call    printit
    call    exit

strlen:
    mov     rdx, rsi

strlen_next:
    cmp     byte [rdx], 0
    jz      strlen_done
    inc     rdx
    jmp     strlen_next

strlen_done:
    sub     rdx, rsi
    ret

    ;; Takes RDI as the address of the message and RDX as the length,
    ;; and prints them.  Restores all used registers when finished.
printit:
    push    rdi
    push    rax
    mov     rdi, STDOUT         ; using STDOUT (see definition above)
    mov     rax, SYS_write      ; Using WRITE in 32-bit mode?
    syscall
    pop     rax
    pop     rdx
    pop     rdi

    ;; Since this terminates the program, I'm not worried about
    ;; managing the stack correctly.
exit:
    mov     rdi, 0
    mov     rax, SYS_exit
    syscall
