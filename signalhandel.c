#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

void handle_sigterm(int sig) {
    printf("\nParent received SIGTERM (%d). Ignoring and continuing...\n", sig);
}

void handle_sigint(int sig) {
    printf("\nParent received SIGINT (%d). Exiting gracefully.\n", sig);
    exit(0);
}

int main() {
    pid_t p1, p2;

    // Register signals
    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    printf("Parent (PID: %d) running...\n", getpid());

    // Create 1st child
    p1 = fork();
    if (p1 == 0) {
        sleep(5);
        printf("Child 1 sending SIGTERM to parent.\n");
        kill(getppid(), SIGTERM);
        exit(0);
    }

    // Create 2nd child
    p2 = fork();
    if (p2 == 0) {
        sleep(10);
        printf("Child 2 sending SIGINT to parent.\n");
        kill(getppid(), SIGINT);
        exit(0);
    }

    // Parent waits indefinitely
    while(1) {
        pause(); // Wait for signal
    }

    return 0;
}