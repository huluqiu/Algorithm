#include "stdio.h"

int main(int argc, char *argv[])
{
    unsigned short a = 100;
    a = ~a;
    printf("%d\n", a);
    return 0;
}
