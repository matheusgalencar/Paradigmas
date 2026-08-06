section .data

    hello db "Olá Mundo!",10
    helloLen equ $-hello

    numero db 7

    vezes db " x "
    vezesLen equ $-vezes

    igual db " = "
    igualLen equ $-igual

    newline db 10


section .bss

    buffer resb 3


section .text

global _start


_start:

    ; Hello World
    mov rax,1
    mov rdi,1
    mov rsi,hello
    mov rdx,helloLen
    syscall


    mov r12,1        ; contador = 1


loop:

    ; multiplicador
cmp r12,10
jne um_digito_contador

; imprime "10"
mov byte [buffer],'1'
mov byte [buffer+1],'0'

mov rax,1
mov rdi,1
mov rsi,buffer
mov rdx,2
syscall

jmp depois_contador


um_digito_contador:

mov rax,r12
add al,'0'
mov [buffer],al

mov rax,1
mov rdi,1
mov rsi,buffer
mov rdx,1
syscall


depois_contador:


    ; " x "
    mov rax,1
    mov rdi,1
    mov rsi,vezes
    mov rdx,vezesLen
    syscall


    ; número
    mov al,[numero]
    add al,'0'
    mov [buffer],al

    mov rax,1
    mov rdi,1
    mov rsi,buffer
    mov rdx,1
    syscall


    ; " = "
    mov rax,1
    mov rdi,1
    mov rsi,igual
    mov rdx,igualLen
    syscall


    ; cálculo
    mov rax,r12
    mov bl,[numero]
    mul bl


    ; converte resultado
    cmp al,10
    jl unidade


    xor ah,ah
    mov dl,10
    div dl

    add al,'0'
    mov [buffer],al

    add ah,'0'
    mov [buffer+1],ah

    mov rax,1
    mov rdi,1
    mov rsi,buffer
    mov rdx,2
    syscall

    jmp fim_linha


unidade:

    add al,'0'
    mov [buffer],al

    mov rax,1
    mov rdi,1
    mov rsi,buffer
    mov rdx,1
    syscall


fim_linha:

    mov rax,1
    mov rdi,1
    mov rsi,newline
    mov rdx,1
    syscall


    inc r12
    cmp r12,11
    jne loop


    ; sair
    mov rax,60
    xor rdi,rdi
    syscall