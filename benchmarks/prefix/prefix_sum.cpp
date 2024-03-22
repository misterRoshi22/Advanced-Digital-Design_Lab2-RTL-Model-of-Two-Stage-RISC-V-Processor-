#include <iostream>
using namespace std;

int main(void) {
    int arr[10] = {0,1,2,3,4,5,6,7,8,9};
    for(int i = 0; i < 9; i++)
        arr[i+1] = arr[i] + arr[i+1];
}
