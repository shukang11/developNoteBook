#include <stdio.h>
#include <string.h>

int add(int a, int b) {
    int res = a + b;
    return res;
}
/*
sub用于对寄存器实施减法，sub a, b, c等价于a = b - c
mov ra, rb 代表将rb寄存器的值复制到ra寄存器
str即将寄存器的值存储到内存中
ldr即将内存中的值读到寄存器;[sp, #12] 代表sp+12 这个地址
以str w0, [sp, #12] 为例，w是4字节的寄存器，这个指令代表将w0寄存器的值存储在sp+12这个地址上，由于w0有4个字节，所以存储后会占据sp+12~sp+16这个内存区域。


这里涉及了3个int变量，
分别是a、b、res，int变量占据4个字节，
因此一共需要12个字节，但ARM64汇编为了提高访问效率要求按照16字节进行对齐，
因此需要16byte的空间，也就是需要在栈上开辟16字节的空间，
我们来看汇编的第一句，正是将sp指针向高位移动16字节。
 sub	sp, sp, #16             ; =16

str	w0, [sp, #12]
str	w1, [sp, #8]
将w0存储在sp+12的格子中，w1存储在sp+8的格子中

最后将栈还原
add	sp, sp, #16             ; =16

*/
/*
以上会转换为下列汇编代码

    sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	str	w0, [sp, #12]
	str	w1, [sp, #8]
	ldr	w0, [sp, #12]
	ldr	w1, [sp, #8]
	add	w0, w0, w1
	str	w0, [sp, #4]
	ldr	w0, [sp, #4]
	add	sp, sp, #16             ; =16
	ret
*/
int main(int argc, char const *argv[])
{
    /* code */
    /*
    使用clang可以将其编译为特定指令集的汇编代码，这里我们将其编译为ARM64指令集的汇编代码。
    clang -S -arch arm64 -isysroot `xcrun --sdk iphoneos --show-sdk-path` compilation.c
    */
    int result = add(1, 4);
    printf("%d", result);
    return 0;
}
