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
    mov     eax, msg            ; Put the address of our message into eax.
    call    strlen              ; call the function strlen.  We're using EAX as our argument.

    mov     edx, eax            ; We know printit wants these two
    mov     eax, msg
    call    printit
    call    exit

strlen:
    push    ebx                 ; Push ebx onto the stack, since the calling scope
                                ; will probably want its state restored correctly, right?
    mov     ebx, eax

strlen_next:
    cmp     byte [eax], 0
    jz      strlen_done
    inc     eax
    jmp     strlen_next

strlen_done:
    sub     eax, ebx            ; Straight from the counted-hello file
    pop     ebx                 ; restore EBX for the calling scope, which is
                                ; expecting its answer in eax
    ret

    ;; Takes EAX as the address of the message and EDX as the
    ;; length, and prints them.  Restores all used registers
    ;; when finished.
printit:
    push    eax
    push    ebx
    push    ecx
    mov     ecx, eax
    mov     ebx, STDOUT
    mov     eax, SYS_write
    int     80h
    pop     ecx
    pop     ebx
    pop     eax
    ret

    ;; Since this terminates the program, I'm not worried about
    ;; managing the stack correctly.
exit:
    mov     ebx, 0
    mov     eax, SYS_exit
    int     80h
