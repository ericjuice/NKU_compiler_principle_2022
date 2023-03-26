#include <time.h>
#include <stdio.h>
int main()
{
    int n[7] = {100, 500, 1000, 5000, 10000, 50000, 100000};
    for (int t = 0; t < 7; t++)
    {
        printf("start at %d times", t + 1);
        int a[n[t]];
        long long head, tail, freq; // timers
        for (int i = 0; i < n[t]; i++)
        {
            a[i] = i * 10; // initial
        }
        clock_t start, end;
	start = clock();
        // loop 1

        for (int i = 0; i < n[t]; i++)
        {
            a[i] = a[i] * 2000;
            a[i] = a[i] / 10000;
        }
        printf("loop 1\n");

        // loop 2.

        // int *b = a;
        // for (int i = 0; i < n[t]; i++)
        // {
        //     *b = *b * 2000;
        //     *b = *b / 10000;
        //     b++;
        // }
        // printf("loop 2\n");
	end = clock();
        double mid=(end - start);
        printf("test n= %d,\ntime:%f ms\n", n[t], mid);
    }
    return 0;
}
