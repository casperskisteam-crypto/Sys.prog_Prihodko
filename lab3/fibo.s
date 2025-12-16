.global main

fibonacci:
        push    %rbp                    # створення стекового кадру
        mov     %rsp, %rbp
        push    %rbx                    # збереження callee-saved регістра
        sub     $24, %rsp               # місце для локальних змінних

        movl    %edi, -20(%rbp)         # збереження аргументу n
        cmpl    $0, -20(%rbp)
        jne     .L2
        movl    $0, %eax                # базовий випадок n = 0
        jmp     .L3

.L2:
        cmpl    $1, -20(%rbp)
        jne     .L4
        movl    $1, %eax                # базовий випадок n = 1
        jmp     .L3

.L4:
        movl    -20(%rbp), %eax
        subl    $1, %eax
        movl    %eax, %edi
        call    fibonacci               # рекурсивний виклик f(n-1)

        movl    %eax, %ebx              # збереження f(n-1)

        movl    -20(%rbp), %eax
        subl    $2, %eax
        movl    %eax, %edi
        call    fibonacci               # рекурсивний виклик f(n-2)

        addl    %ebx, %eax              # f(n-1) + f(n-2)

.L3:
        mov     -8(%rbp), %rbx          # відновлення rbx
        leave                           # завершення стекового кадру
        ret

.LC0:
        .string "Enter the Fibonacci number you want to calculate: "
.LC1:
        .string "%d"
.LC2:
        .string "Please enter a number between 0 and 93."
.LC3:
        .string "The %dth Fibonacci number is %llu\n"

main:
        push    %rbp                    # створення стекового кадру
        mov     %rsp, %rbp
        sub     $16, %rsp

        mov     $.LC0, %edi
        mov     $0, %eax
        call    printf                  # вивід запрошення

        lea     -4(%rbp), %rax
        mov     %rax, %rsi
        mov     $.LC1, %edi
        mov     $0, %eax
        call    __isoc99_scanf           # зчитування n

        mov     -4(%rbp), %eax
        test    %eax, %eax
        js      .L6                     # перевірка n < 0

        cmpl    $93, %eax
        jle     .L7                     # перевірка n <= 93

.L6:
        mov     $.LC2, %edi
        call    puts                    # повідомлення про помилку
        mov     $1, %eax
        jmp     .L9

.L7:
        mov     -4(%rbp), %eax
        mov     %eax, %edi
        call    fibonacci               # виклик fibonacci(n)

        mov     %rax, %rdx
        mov     -4(%rbp), %eax
        mov     %eax, %esi
        mov     $.LC3, %edi
        mov     $0, %eax
        call    printf                  # вивід результату

        mov     $0, %eax

.L9:
        leave                           # завершення main
        ret

.section .note.GNU-stack,"",@progbits
