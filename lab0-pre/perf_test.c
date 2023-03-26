#include <time.h>
#include <stdio.h>
int main()
{
    int n = 100000;
    int a[n];
    clock_t start, end;
    for (int i = 0; i < n; i++)
    {
        a[i] = i * 10; // initial
    }
    start = clock();
    // loop 1

    // for (int i = 0; i < n; i++)
    // {
    //     a[i] = a[i] * 2000;
    //     a[i] = a[i] / 10000;
    // }
    // printf("loop 1\n");

    // loop 2.

    int *b = a;
    for (int i = 0; i < n; i++)
    {
        *b = *b * 2000;
        *b = *b / 10000;
        b++;
    }
    printf("loop 2\n");
    end = clock();
    double mid=(end - start);
    printf("time:%f\n", (double) mid/ CLOCKS_PER_SEC);
    return 0;
}
