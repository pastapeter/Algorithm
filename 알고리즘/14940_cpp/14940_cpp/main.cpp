//
//  main.cpp
//  14940_cpp
//
//  Created by Jung peter on 5/25/23.
//

#include <iostream>
#include <deque>
using namespace std;

int map[1001][1001];
bool visited[1001][1001];
int dx[4] = {-1,0,1,0};
int dy[4] = {0, 1, 0, -1};
int n;
int m;

void bfs(pair<int, int> start) {
  
  deque<pair<int, int>> queue = { start };
  map[start.second][start.first] = 0;
  visited[start.second][start.first] = true;
  
  while (queue.size() != 0) {
    pair<int, int> poped = queue.front(); queue.pop_front();
    for(int i=0;i<4;i++) {
      int nx = poped.first + dx[i];
      int ny = poped.second + dy[i];
      
      if(nx < 0 || nx >= m || ny < 0 || ny >= n) continue;
      if(map[ny][nx] != 0 && !visited[ny][nx]) {
        queue.push_back({ nx, ny});
        visited[ny][nx] = true;
        map[ny][nx] = map[poped.second][poped.first] + 1;
      }
      
    }
  }
  
}

int main(int argc, const char * argv[]) {
  pair<int, int> start;
  cin >> n >> m;
  for(int y=0;y<n;y++) {
    for(int x=0;x<m;x++) {
      cin >> map[y][x];
      if (map[y][x] == 2) {
        start = { x, y};
      }
    }
  }
  bfs(start);
  for(int y=0;y<n;y++) {
    for(int x=0;x<m;x++) {
      if (map[y][x] != 0 && !visited[y][x]) {
        map[y][x] = -1;
      }
      cout << map[y][x] << " ";
    }
    cout << endl;
  }
  return 0;
}
