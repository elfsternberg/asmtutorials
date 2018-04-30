    ;; This is an includes file.  It doesn't have its own compilation
    ;; capabilities.  There is no namespacing in assembly language;
    ;; try not to use these names in your own code.

    ;; sys/unistd_32.h
%define     SYS_write	1
%define     SYS_exit	60

    ;; unistd.h
%define STDOUT		1

    ;; strlen() function.  Takes rdx as an argument - the pointer to
    ;; the initial string.  Returns rdx as the result - the length of
    ;; the string.
    
strlen:
    push    rsi
    mov     rsi, rdx

strlen_next:
    cmp     byte [rdx], 0
    jz      strlen_done
    inc     rdx
    jmp     strlen_next

strlen_done:
    sub     rdx, rsi
    pop     rsi
    ret

    ;; puts() function - puts a string to the console.  Takes RSI as
    ;; its only argument - the pointer to the beginning of the string.

puts:
    push    rdx                 ; RDX (data) is used as the length of the message
    push    rax                 ; RAX is the instruction to WRITE
    push    rdi                 ; RDI (destination) is used as an instruction to WRITE

    mov     rdx, rsi
    call    strlen

    ;; Because I chose to use RDX as the target for strlen, I don't need to
    ;; do the pop/push dance as I did in the 32-bit version.
    
    mov     rdi, STDOUT         ; using STDOUT (see definition above)
    mov     rax, SYS_write      ; Using WRITE in 32-bit mode?
    syscall

    ;; Likewise, because I chose RSI as the Source (pointer) to my
    ;; message, it remains unchanged during the lifetime of this
    ;; routine (unless there are any bugs in strlen) and I don't
    ;; have to restore it either.
    
    pop     rdi
    pop     rax
    pop     rdx
    ret

    ;; exit().  Straight from the original.
    
exit_program:
    mov     rdi, 0
    mov     rax, SYS_exit
    syscall
