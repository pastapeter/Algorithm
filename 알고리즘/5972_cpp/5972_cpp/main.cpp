//
//  main.cpp
//  5972_cpp
//
//  Created by Jung peter on 5/26/23.
//

#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
using namespace std;

// 다익스트라?
// start 1
int n, m;
vector<vector<pair<int, int>>> graph;
int dist[50001] = { 0 };

int dijkstra(int start) {
  
  priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> queue;
  queue.push({ start, 0});
  dist[start] = 0;
  
  while (!queue.empty()) {
    pair<int, int> cur = queue.top(); queue.pop();
    int pos = cur.first;
    int d = cur.second;
    
    for(auto routes: graph[pos]) {
      int next = routes.first;
      int nextDis = routes.second;
      if( dist[next] > dist[pos] + nextDis) {
        dist[next] = dist[pos] + nextDis;
        queue.push(routes);
      }
      
    }
  }
  return dist[n];
}

int main(int argc, const char * argv[]) {
  cin >> n >> m;
  for(int i=0;i<=n;i++) {
    graph.push_back(vector<pair<int, int>>());
  }
  fill_n(dist, n+1, INT_MAX);
  for(int i=0;i<m;i++) {
    int a, b, c;
    cin >> a >> b >> c;
    graph[a].push_back({b, c});
    graph[b].push_back({a, c});
  }
  cout << dijkstra(1);
  return 0;
}
