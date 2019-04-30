#include <stdlib.h>
#include <stdio.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

void get_message_length(char *msg) {
    int length = strlen(msg);
    printf("Your message length is: %d\n", length);
    printf(msg);
    exit(0);
}

void loop() {
    char buf[1024];
    while (true) {
        char *result = fgets(buf, 1024, stdin);
        if (!result) {
            continue;
        }

        char *arg = strtok(result, "\n");
        if(arg == NULL) {
            continue;
        }

        get_message_length(arg);
    }
}

int main(int argc, char **argv) {
    setbuf(stdout, NULL);
    printf("Welcome to our length service!\r\n");
    printf("Please type in the string, that you want us to get the length of.\r\n\r\n");
    loop();
    return 0;
}
