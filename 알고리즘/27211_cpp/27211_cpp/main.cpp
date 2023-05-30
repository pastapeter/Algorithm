//
//  main.cpp
//  27211_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <deque>
#include <vector>
using namespace std;
int dx[4] = {0, 0, 1, -1};
int dy[4] = {1, -1, 0, 0};
int n,m;
int map[1001][1001] = { 0 };
bool visited[1001][1001] = { false };
// 0이면 비어있는것, 1이면 숲으로 막혀있는 것임

void bfs(pair<int, int> start) {
  deque<pair<int, int>> queue = { start };
  visited[start.second][start.first] = true;
  while( queue.size() != 0) {
    pair<int, int> poped = queue.front(); queue.pop_front();
    for(int i=0;i<4;i++) {
      
      int nx = poped.first + dx[i];
      int ny = poped.second + dy[i];
      
      if (nx < 0) {
        nx += m;
      }
      if (nx >= m) {
        nx -= m;
      }
      if (ny < 0) {
        ny += n;
      }
      if (ny >= n) {
        ny -=n;
      }
      
      if(!visited[ny][nx] && map[ny][nx] == 0) {
        queue.push_back({nx, ny});
        visited[ny][nx] = true;
      }
      
    }
    
    
  }
}

int main(int argc, const char * argv[]) {
  cin >> n >> m;
  for(int y=0;y<n;y++) {
    for(int x=0;x<m;x++) {
      cin >> map[y][x];
    }
  }
  int answer = 0;
  for(int y=0;y<n;y++) {
    for(int x=0;x<m;x++) {
      if (!visited[y][x] && map[y][x] == 0) {
        bfs({x, y});
        answer++;
      }
    }
  }
  cout << answer;
  return 0;
}
