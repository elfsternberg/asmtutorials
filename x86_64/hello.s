    ;; Hello World Program #2
    ;; Compile with: nasm -f elf64 hello.s
    ;; Link with: ld -m elf_x86_64 -o hello hello.o
    ;; Run with: ./hello

    ;; The following includes are derived from:
    ;; sys/unistd_64.h
%define     SYS_write	1
%define     SYS_exit	60

    ;; The following includes are derived from:
    ;; unistd.h
%define STDOUT		1

;;; 'global' is the directive that tells the NASM the address of the
;;; first instruction to run.
    
global _start

section .data
    msg     db  "Hello You Beautiful Human", 0Ah
    len     equ $-msg           ; The $ is a NASM helper that means
	                            ; "The address of the current
	                            ; instruction.  'equ' is a NASM
                                ; macro that performs the math and
	                            ; places in the 'len' constant the
	                            ; difference between the start of the
	                            ; current instruction and the 'msg'.

section .text    
_start:
    mov     rdx, len            ; Mov the address of 'len' to register RDX
    mov     rsi, msg            ; Mov the address of the message to RSI (Source Index)
    mov     rdi, STDOUT         ; using STDOUT (see definition above)
    mov     rax, SYS_write      ; Access WRITE in 64-bit linux
    syscall                     ; Call the kernel to run the WRITE command.

    ;; Note that it's always register AX that we use to tell the kernel
    ;; what we want it to do.  Depending on the kernel instruction, other
    ;; registers may be used to fill out the command.

    mov     rdi, 0              ; Mov '0' to be our exit code
    mov     rax, SYS_exit       ; Access the exit command
    syscall                     ; Call the kernel to run the EXIT command.
    
