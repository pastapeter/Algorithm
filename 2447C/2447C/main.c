//
//  main.c
//  2447C
//
//  Created by abc on 2021/06/30.
//

#include <stdio.h>

char arr[7000][7000] = {0,};

void printStar(int N, int x, int y){
    if (N==1){
        arr[y][x] = '*';
        return;
    }
    int val = N/3;
    for(int i =0;i<3;i++){
        for(int j=0;j<3;j++){
            if(i==1 && j==1){
                continue;
            }
            else {
                printStar(val, x+j*val, y+i*val);
            }
        }
    }
}


int main(int argc, const char * argv[]) {
    
    int N;
    scanf("%d", &N);
    
    for(int i=0;i<N;i++){
        for(int j=0;j<N;j++){
            arr[i][j] = ' ';
        }
    }
    
    printStar(N, 0, 0);
    
    for(int i=0;i<N;i++){
        for(int j=0;j<N;j++){
            printf("%c", arr[i][j]);
        }
        printf("\n");
    }

}
