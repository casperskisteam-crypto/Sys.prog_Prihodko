global start
section .text
start:
mov rax, 1
mov rdi, 1
mov rsi, message
mov rdx, msg_len
syscall
mov rax, 60
xor rdi, rdi
syscall
section .data
message: db "KI-241 Prihodko", 10
msg_len equ $ - message
