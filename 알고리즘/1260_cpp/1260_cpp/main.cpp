//
//  main.cpp
//  1260_cpp
//
//  Created by Jung peter on 5/24/23.
//

#include <iostream>
#include <deque>
#include <vector>
#include <algorithm>

using namespace std;

int n;
int m;
int v;
vector<vector<int>> graph(1001, vector<int>());
vector<int> bfs_res;
vector<int> dfs_res;
bool visited_dfs[1001] = { false };

void bfs(int start) {
  deque<int> queue = { start };
  bool visited[1001] = { false };
  visited[start] = true;
  
  while (queue.size() != 0) {
    int poped = queue.front(); queue.pop_front();
    bfs_res.push_back(poped);
    sort(graph[poped].begin(), graph[poped].end());
    for(auto next: graph[poped]) {
      if (!visited[next]) {
        queue.push_back(next);
        visited[next] = true;
      }
    }
  }
  
}

void dfs(int start, int depth) {
  dfs_res.push_back(start);
  visited_dfs[start] = true;
  if (depth == n-1) {
    return;
  }
  
  vector<int> candidates = graph[start];
  sort(candidates.begin(), candidates.end());
  for(auto candidate: candidates) {
    if (!visited_dfs[candidate]) {
      dfs(candidate, depth+1);
    }
  }
  
}

int main(int argc, const char * argv[]) {
  cin >> n >> m >> v;
  for(int i=0;i<m;i++) {
    int from, to;
    cin >> from >> to;
    graph[from].push_back(to);
    graph[to].push_back(from);
  }
  dfs(v, 0);
  bfs(v);
  for(auto i:dfs_res) {
    cout << i << " ";
  }
  cout << endl;
  for(auto i:bfs_res) {
    cout << i << " ";
  }
  return 0;
}
