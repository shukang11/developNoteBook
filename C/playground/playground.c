#include <sys/types.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <sys/time.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

int main(int argc, char const *argv[])
{
    char *host = "11.5.6.7";
    unsigned long inaddr;
    inaddr  = inet_addr(host);
    printf("%lu", inaddr);
    printf("%d", htons(11));
    return 0;
}
