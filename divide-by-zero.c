#include <stdio.h>

int main() {
    int x = 9;
    for (; x >= 0; x--) {
        printf("%d\n", (4 / x));
    }
    return 0;
}