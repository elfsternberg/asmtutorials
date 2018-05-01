    ;; Hello World Program #7 & 8: Println (in functions) and command line arguments

%include    "functions.asm"

section .text
    global _start

;;; We'll show how to access any arguments passed in by the
;;; environment (usually the Shell).
    
_start:
    pop     ecx             ; The first object on the stack is ARGC: The number of arguments passed in.

next_arg:   
    cmp     ecx, 0h         ; If there are no arguments, or no more arguments left, exit.
    jz      exit
    pop     eax             ; The stack currently has pointer to the messages, null-terminated
                            ; So we pop one off, put it into the register used by putslf, and...
    call    putslf
    dec     ecx             ; Drop the count by one, and try again. 
    jmp     next_arg

exit:
    call    exit_program
