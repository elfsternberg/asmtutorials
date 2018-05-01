    ;; This is an includes file.  It doesn't have its own compilation
    ;; capabilities.  There is no namespacing in assembly language;
    ;; try not to use these names in your own code.
    
    ;; sys/unistd_32.h
%define     SYS_write	4
%define     SYS_exit	1

    ;; unistd.h
%define STDOUT		1

    ;; A single null-terminated line feed.
section .data
    _lf db 0ah, 00h

section .text

    ;; strlen() function.  Takes eax as an argument - the pointer to
    ;; the initial string.  Returns eax as the result - the length of
    ;; the string.
    
strlen:
    push    ebx                 ; We'll be borrowing this register, so we put its
                                ; current value on the stack.
    mov     ebx, eax

    ;; Note that even though these have underscores to indicate that
    ;; outside users should not use them, they're still globally
    ;; accesible in this program's namespace.  A user could
    ;; theoretically call _strlen_done from anywhere.  Assembly gives
    ;; you ALL the opportunities to shoot yourself in the foot!
_strlen_next:
    cmp     byte [eax], 0
    jz      _strlen_done
    inc     eax
    jmp     _strlen_next

_strlen_done:
    sub     eax, ebx
    pop     ebx                 ; Restore the register
    ret

    ;; Puts() function - puts a string to the console.  Takes EAX as
    ;; its only argument - the pointer to the beginning of the string.
    
puts:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    strlen          ; Uses EAX as the pointer to the beginning of the string.
                            ; Returns EAX as the length of the string

    mov     edx, eax        ; Move the length of the string into EDX, where WRITE expects
    pop     eax             ; Restore EAX from the stack

    push    eax             ; Put the value BACK on the stack.
    mov     ecx, eax        ; Put the pointer to the message into ECX, where WRITE expects
    mov     ebx, STDOUT
    mov     eax, SYS_write
    int     80h
    pop     eax             ; Restore registers in reverse order.
    pop     ebx
    pop     ecx
    pop     edx
    ret

putslf:
    call    puts                ; Print the string
    push    eax                 ; Preserve this register
    mov     eax, _lf
    call    puts
    pop     eax
    ret

    ;; exit().  Straight from the original.
    
exit_program:
    mov     ebx, 0
    mov     eax, SYS_exit
    int     80h
    
