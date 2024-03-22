#include <iostream>
using namespace std;

int arr[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

void swap(int a, int b) {
    int x = arr[a];
    int y = arr[b];
    arr[a] = y;
    arr[b] = x;
}

int main(void) {
    swap(5, 7);
    swap(0, 1);
}
