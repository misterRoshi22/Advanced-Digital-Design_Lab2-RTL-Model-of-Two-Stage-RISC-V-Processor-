#include <iostream>
using namespace std;

int main(void) {
    int arr[10] = {9, 6, 3, 8, 5, 2, 7, 4, 1, 0};
    int n = 10;
    
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n-i-1; j++) {
            if(arr[j] > arr[j+1]) {
                swap(arr[j], arr[j+1]);
            }
        }
    }
}
