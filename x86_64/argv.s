    ;; Hello World Program #5: Includes

%include    "functions.asm"

section .text
    global _start

_start:
    pop     rcx             ; Counter. The first object is ARGC, the count of arguments.

next_arg:   
    cmp     rcx, 0h         ; If there are no arguments, or no more arguments left, exit.
    jz      exit
    pop     rsi             ; The stack currently has pointer to the messages, null-terminated
                            ; So we pop one off, put it into the register used by putslf, and...
    call    putslf
    dec     rcx             ; Drop the count by one, and try again. 
    jmp     next_arg

exit:
    call    exit_program
