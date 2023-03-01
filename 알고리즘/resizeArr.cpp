#include <iostream>
using namespace std;


int* removeFirst(int* arr) {
    return arr = arr+1;
}

int main() {

    int* oldArr = new int[10];
    for(int i=0;i<10;i++) {
        oldArr[i] = i;
    }

    //  for(int i=0;i<10;i++) {
    //     cout << oldArr[i] << endl;
    // }

    int* newArr = new int[20];
    for(int i=0;i<10;i++) {
        newArr[i] = oldArr[i];
    }

    delete[] oldArr;
    oldArr = newArr;
    newArr = NULL;
    for(int i=0;i<10;i++) {
        cout << oldArr[i] << " ";
    }
    cout << endl;
    oldArr = removeFirst(oldArr);

    for(int i=0;i<9;i++) {
        cout << oldArr[i] << " ";
    }

    return 0;
}