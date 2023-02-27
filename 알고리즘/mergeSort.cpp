#include <iostream>
using namespace std;

//2개의 subarray를 array로 합침
void merge(int array[], int left, int mid, int right) {
    int subArraySize = mid - left +1;
    int subArraySize2 = right - mid;

    //동적할당 조져
    auto *leftArr = new int[subArraySize];
    auto *rightArr = new int[subArraySize2];

    for(int i=0;i<subArraySize;i++){
        leftArr[i] = array[i+left];
    }
    for(int i=0;i<subArraySize2;i++) {
        rightArr[i] = array[i+mid+1];
    }

    int i = 0;
    int j = 0;
    int k = left;
    //합쳐주기
    while (i < subArraySize && j < subArraySize2) {
        if (leftArr[i] <= rightArr[j]) {
            array[left] = leftArr[i];
            i++;
        } else {
            array[left] = rightArr[j];
            j++;
        }
        left++;
    }

    //남은거
    while(i < subArraySize) {
        array[left++] = leftArr[i++];
    }
    while(j < subArraySize2) {
        array[left++] = rightArr[j++];
    }

    delete[] leftArr;
    delete[] rightArr;

}

void mergeSort(int array[], int begin, int end) {
    if (begin >= end) { return; }
    int mid = (end + begin) / 2;
    mergeSort(array, begin, mid);
    mergeSort(array, mid+1, end);
    merge(array, begin, mid, end);
}

void printArray(int A[], int size)
{
    for (auto i = 0; i < size; i++)
        cout << A[i] << " ";
}

int main() {
    int arr[] = { 12, 11, 13, 5, 6, 7 };
    auto arr_size = sizeof(arr) / sizeof(arr[0]);
    printArray(arr, arr_size);
    mergeSort(arr, 0, arr_size-1);
    cout << "\nsorted Array is \n";
    printArray(arr, arr_size);
    return 0;
}