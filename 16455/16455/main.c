//
//  main.c
//  16455
//
//  Created by abc on 2021/07/02.
//

#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b){
    int num1 = *(int *)a;
    int num2 = *(int *)b;
    
    if(num1 < num2) return -1;
    if(num1 > num2) return 1;
    
    return 0;
}

int kth(int *a, int n, int k){
    qsort(a, n, sizeof(int), compare);
    return a[k];
}

int main(int argc, const char * argv[]) {
    
}
