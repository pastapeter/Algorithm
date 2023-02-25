#include <string>
#include <iostream>
#include <vector>

using namespace std;

int parent[200] = {0,};

int findparent(int x) {
    if (parent[x] == x) {
        return x;
    }
    parent[x] = findparent(parent[x]);
    return parent[x];
}

void unionFind(int a, int b) {
    int rootA = findparent(a);
    int rootB = findparent(b);
    if (rootA < rootB) {
        parent[rootB] = rootA;
    } else {
        parent[rootA] = rootB;
    }
}

int solution(int n, vector<vector<int>> computers) {
    int answer = 0;
    for(int i=0;i<n;i++) {
        parent[i] = i;
    }
    int matrix[200][200] = {-1, };
    
    for(int y=0;y<n;y++) {
        for(int x=0;x<n;x++) {
            matrix[y][x] = computers[y][x];
        }
    }
    
    for(int y=0;y<n;y++) {
        for(int x=0;x<n;x++) {
            if ((y!=x) && matrix[y][x] == 1) {
                unionFind(x,y);
            }
        }
    }
    
    // 큰덩이리 갯수
    for(int i=0;i<n;i++) {
        if (parent[i] == i) {
            answer++;
        }
    }
    return answer;
}