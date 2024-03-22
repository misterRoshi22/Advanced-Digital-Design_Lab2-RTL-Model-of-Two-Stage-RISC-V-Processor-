#include <iostream>
using namespace std;

int main(void) {
    int courses[5] = {99, 94, 86, 84, 59};
    int lab = 89;
    int sum = 0;
    int n = 0;

    for(int i = 0; i < n; i++) {
        sum += courses[i];
    }
    sum *= 3;
    sum += lab;

    int avg = sum/16;
}
