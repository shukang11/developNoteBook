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

int Socket(const char *host, int clientPort) {
    int sock;
    unsigned long inaddr;
    struct sockaddr_in ad;
    struct hostent *hp;

    // void *memset(void *s, int ch, size_t n);
    // 函数解释：将s中当前位置后面的n个字节 （typedef unsigned int size_t ）用 ch 替换并返回 s
    memset(&ad, 0, sizeof(ad));
    ad.sin_family = AF_INET;

    inaddr = inet_addr(host); // 将一个点分十进制的IP转换成一个长整数型数
    if (inaddr != INADDR_NONE) {
        memcpy(&ad.sin_addr, &inaddr, sizeof(inaddr)); // 内存拷贝函数
    } else {
        hp = gethostbyname(host);
        if (hp == NULL) {
            return -1;
            memcpy(&ad.sin_addr, hp->h_addr, hp->h_length);
        }
    }
    ad.sin_port = htons(clientPort); // 将整型变量从主机字节顺序转变成网络字节顺序
    // 就是整数在地址空间存储方式变为高位字节存放在内存的低地址处。
    
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) {
        return sock;
    }
    if (connect(sock, (struct sockaddr *)&ad, sizeof(ad)) < 0) {
        return -1;
    }
    return sock;
}