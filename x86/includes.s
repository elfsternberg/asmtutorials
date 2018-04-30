    ;; Hello World Program #5: Includes

%include    "functions.asm"

section .data
    msg     db  "Cool, we can now do something like structured programming.", 0Ah, 00h

section .text
    global _start

_start:
    mov     eax, msg            ; Put the address of our message into eax.
    call    puts                ; Calls strlen internally!
    call    exit_program

