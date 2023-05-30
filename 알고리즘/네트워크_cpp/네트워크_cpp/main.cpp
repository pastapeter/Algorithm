//
//  main.cpp
//  네트워크_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <string>
#include <vector>
#include <unordered_set>
#include <iostream>
#include <deque>
using namespace std;
int parents[201];
bool visited[201];
int answer = 0;

int find_parent(int child) {
    if (parents[child] == child) {
        return parents[child];
    }
    parents[child] = find_parent(parents[child]);
    return parents[child];
}

void union_find(int child1, int child2) {
    int root1 = find_parent(child1);
    int root2 = find_parent(child2);
    if (root1 != root2) {
        parents[root1] = root2;
    }
}

/*
 bfs로 푸는 방법은 bfs로 연결되어있는 node탐색
 모든 노드를 시작지점으로 모두 이용하되, visited를 활용한다.
 */
void bfs(int start, vector<vector<int>> computers) {
    deque<int> queue = { start };
    visited[start] = true;
    answer ++;
    while(queue.size() != 0) {
        int poped = queue.front(); queue.pop_front();
        
        for(int i=0;i<computers[poped].size();i++) {
            if (poped == i) continue;
            if (!visited[i] && computers[poped][i] == 1) {
                visited[i] = true;
                queue.push_back(i);
            }
        }
        
    }
    
}

int solution(int n, vector<vector<int>> computers) {
    for(int i=0;i<n;i++) {
        parents[i] = i;
    }
    
    /*
     Union_Find를 사용하는 이유 최소신장트리를 구할때 최상위 노드는 하나일뿐
     하나의 list에서 여러tree가 나올수 있음
     여러 Tree를 구해할 때 어쨋든 재귀를 통해 구할 수 있음
     그렇다면, 여러개의 네트워크를 구할때 방법 중하나는 최상위 루트를 여러개를 구하면 된다. -> Union find
     */
     
    for(int y=0;y<n;y++) {
        for(int x=0;x<n;x++) {
            if (computers[y][x] == 1 && y != x) {
                union_find(x, y);
            }
        }
    }
    
    for(int i=0;i<n;i++) {
        if (parents[i] == i) answer++;
    }
    
    return answer;
}

int main(int argc, const char * argv[]) {
  // insert code here...
  std::cout << "Hello, World!\n";
  return 0;
}
