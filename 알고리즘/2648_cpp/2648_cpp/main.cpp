//
//  main.cpp
//  2648_cpp
//
//  Created by Jung peter on 5/23/23.
//

#include <iostream>
#include <vector>
#include <deque>
#include <algorithm>
using namespace std;

int maps[101][101];
int n;
int maxHeight = 0;
int minHeight = 101;
int dx[4] = {-1,1,0,0};
int dy[4] = {0,0,-1,1};
int answer = 1;

int bfs(int map[101][101], int height) {
  bool visited[101][101] = { };
  int cnt = 0;
  for(int y=0;y<n;y++) {
    for(int x=0;x<n;x++) {
      if (map[y][x] != height && !visited[y][x]) {
        cnt++;
        deque<pair<int, int>> queue = {{ x, y }};
        visited[y][x] = true;
        
        while (queue.size() != 0) {
          
          pair<int, int> poped = queue.front(); queue.pop_front();
          
          for(int i=0;i<4;i++) {
            
            int nx = poped.first + dx[i];
            int ny = poped.second + dy[i];
            
            if (nx < 0 || nx >= n || ny < 0 || ny >= n) continue;
            if (!visited[ny][nx] && map[ny][nx] != height) {
              queue.push_back({ nx, ny });
              visited[ny][nx] = true;
            }
            
          }
        }
      }
    }
  }
  return cnt;
}

void checkFlooded(int height) {
  int newMap[101][101];
  for(int y=0;y<n;y++){
    for(int x=0;x<n;x++) {
      newMap[y][x] = maps[y][x];
      if (newMap[y][x] <= height) {
        newMap[y][x] = height;
      }
    }
  }
  answer = max(answer, bfs(newMap, height));
}

int main(int argc, const char * argv[]) {
  cin >> n;
  for(int y=0;y<n;y++) {
    for(int x=0;x<n;x++) {
      cin >> maps[y][x];
      maxHeight = max(maxHeight, maps[y][x]);
      minHeight = min(minHeight, maps[y][x]);
    }
  }
  for(int height=minHeight;height<=maxHeight;height++) {
    checkFlooded(height);
  }
  cout << answer;
  return 0;
}
