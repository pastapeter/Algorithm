//
//  main.cpp
//  prim_cpp
//
//  Created by Jung peter on 5/30/23.
//

#include <iostream>
#include <queue>
#include <vector>
using namespace std;
vector<vector<pair<int, int>>> graph;
int v, e;
bool visited[1001];
void prim(int start) {
  priority_queue<pair<int, int>> q;
  int answer = 0;
  int cnt = 0;
  q.push({start, 0}); //노드, 값
  while (!q.empty()) {
    if (cnt == v) break;
    pair<int, int> poped = q.top(); q.pop();
    if (!visited[poped.first]) {
      visited[poped.first] = true;
      answer += poped.second;
      cnt += 1;
      for(auto ele: graph[poped.first]) {
        q.push(ele);
      }
    }
  }
}

int main(int argc, const char * argv[]) {
  cin >> v >> e;
  for(int i=0;i<e;i++) {
    int from, to, c;
    graph[from].push_back({ to, c});
    graph[to].push_back({ from, c});
  }
  
  prim(0);
  return 0;
}
