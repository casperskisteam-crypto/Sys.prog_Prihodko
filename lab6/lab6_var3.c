#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

int main() {
    pid_t pid;
    int status;
    FILE *f;

    // parent пише в файл
    f = fopen("KI-241_Prihodko_Kyrylo.txt", "a");
    if (f == NULL) {
        printf("Помилка: не відкрився файл!\n");
        return 1;
    }
    fprintf(f, "parent PID=%d\n", getpid());
    fclose(f);

    pid = fork();

    if (pid < 0) {
        printf("Помилка: fork() не спрацював!\n");
        return 1;
    }

    if (pid == 0) {
        // child пише в файл
        f = fopen("KI-241_Prihodko_Kyrylo.txt", "a");
        if (f == NULL) {
            printf("Child: помилка відкриття файлу!\n");
            exit(1);
        }
        fprintf(f, "child PID=%d\n", getpid());
        fclose(f);

        // команда B (варіант 3): ping -c 2 1.1.1.1
        execlp("ping", "ping", "-c", "2", "1.1.1.1", NULL);

        // якщо команда не існує / exec не спрацював
        printf("Помилка: команда ping не запустилась!\n");
        exit(127);
    }

    // parent чекає child
    wait(&status);

    // перевірка як завершився child
    if (WIFEXITED(status)) {
        int code = WEXITSTATUS(status);

        if (code == 0) {
            printf("Child завершився успішно (код 0)\n");
        } else {
            printf("Child завершився з помилкою (код %d)\n", code);
        }
    } else {
        printf("Child завершився не через exit()\n");
    }

    return 0;
}
