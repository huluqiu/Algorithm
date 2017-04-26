#include<stdio.h>

void set(unsigned int a[], int n) {
    a[n / 32] |= 1 << (n & 0x1F);
}

void printBit(unsigned int l[], int count) {
    for (int i = 0; i < count; ++i) {
        for (int j = 0; j < 32; ++j) {
            if (1 & (l[i] >> j))
                printf("%d\n", i *32 + j);
        }
    }
}

int main(int argc, char *argv[])
{
    int n = 100;
    int count = (n - 1) / 32 + 1;
    unsigned int a[count];
    for (int i = 0; i < count; ++i) {
        a[i] = 0;
    }
    set(a, 0);
    set(a, 31);
    set(a, 32);
    set(a, 33);
    set(a, 100);
    set(a, 12);
    printBit(a, count);
    return 0;
}
