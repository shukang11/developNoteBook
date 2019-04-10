#include <stdio.h>
#include <string.h>

int main(int argc, char const *argv[])
{
    /* code */
    int a, b;
    char op[] = "*";
    a = 10;
    b = 12;
    int result;
    if (strcmp(op, "+") == 0) {
        result = a + b;
    } else if (strcmp(op, "-") == 0) {
        result = a - b;
    } else if (strcmp(op, "*") == 0) {
        result = a * b;
    } else if (strcmp(op, "/") == 0) {
        result = a / b;
    }
    printf("%d %s %d = %d", a, op, b, result);
    return 0;
}
