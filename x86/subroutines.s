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
    msg     db  "Okay, so we're doing 32-bit subroutines now, huh?", 0Ah, 00h

section .text
    global _start

_start:
    mov     ecx, msg            ; Put the address of our message into eax.
    call    strlen              ; call the function strlen.  We're using EAX as our argument.
    call    printit
    call    exit

strlen:
                                ; will probably want its state restored correctly, right?
    mov     edx, ecx

strlen_next:
    cmp     byte [edx], 0
    jz      strlen_done
    inc     edx
    jmp     strlen_next

strlen_done:
    sub     edx, ecx            ; Straight from the counted-hello file
    ret

    ;; Takes EAX as the address of the message and EDX as the
    ;; length, and prints them.  Restores all used registers
    ;; when finished.  EDX contains the count.
printit:
    push    ebx
    push    eax
    mov     ebx, STDOUT
    mov     eax, SYS_write
    int     80h
    pop     eax
    pop     ebx
    ret

    ;; Since this terminates the program, I'm not worried about
    ;; managing the stack correctly.
exit:
    mov     ebx, 0
    mov     eax, SYS_exit
    int     80h
