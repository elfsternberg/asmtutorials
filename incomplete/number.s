;; Pure assembly, library-free Linux threading demo
bits 32
global _start

;; sys/syscall.h
%define SYS_write	1
%define SYS_exit	60

;; unistd.h
%define STDOUT		1

section .data
hello:	db `Goodbye\10`
    
section .text
_start:
	mov eax, 9234d              ; The number we're processing; this is
                                ; the dividend target for the div operation
    xor esi, esi                ; fast zero
.loop:
    mov edx, 0d                 ; counter
    mov ebx, 10d                ; divisor
    div ebx
    add edx, 48d                ; the remainder, plus the ASCII for '0'
                                ; the quotient is put into eax
    push edx                    ; onto the stack
    inc esi                     ; Increment counter
    cmp eax, 0d                 ; if EAX is zero, we're done.
    jz .print
    jmp .loop
.print:    
    cmp esi, 0d                  ; if counter is zero, we're done.
    jz .exit
    dec esi                     ; decrement the counter
    pop ecx                ; copy the address of the stack pointer to edx
    mov edx, 1                  ; One byte
	mov ebx, STDOUT             ; To stdout
	int SYS_write          ; Do it!
    jmp .print

.exit:
    mov esi, hello                ; move the contents of the stack pointer into ECX
    mov ecx, 6                  ; One byte
	mov ebx, STDOUT             ; To stdout
	mov eax, SYS_write          ; Do it!
	mov edi, 0                  ; Success!
	mov eax, SYS_exit           ; Do it!
	syscall
