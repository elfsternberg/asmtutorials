    ;; Hello World Program #5: Includes

%include    "functions.asm"

section .data
    msg     db  "Cool, we can now do something like structured programming - 64 bit version.", 0Ah, 00h

section .text
    global _start

_start:
    mov     rsi, msg            ; Put the address of our message into eax.
    call    puts                ; Calls strlen internally!
    call    exit_program
