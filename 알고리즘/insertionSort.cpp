#include <iostream>
using namespace std;

void insertionSort(int arr[], int n) {
    int i, key, j;
    // i는 1부터시작하는게 맞음
    for(i=1;i<n;i++) {
        // arr[i]가 보통 키임
        key = arr[i];
        // j는 i 바로 앞임, 0까지 가고있음
        j = i-1;
        // j가 0보다 크거나 같을때, 만약에 키보다 큰게있어
        while(j>=0 && arr[j] > key) {
            //그러면 한칸씩 뒤로 미는거임
            arr[j+1] = arr[j];
            j = j-1;
        }
        //그리고 자리에다가 넣어주는거임
        arr[j+1] = key;
    }
}

void printArray(int arr[], int n)
{
    int i;
    for (i = 0; i < n; i++)
        cout << arr[i] << " ";
    cout << endl;
}
 
// Driver code
int main()
{
    int arr[] = { 12, 11, 13, 5, 6 };
    int N = sizeof(arr) / sizeof(arr[0]);
 
    insertionSort(arr, N);
    printArray(arr, N);
 
    return 0;
}
// This is code is contributed by rathbhupendra