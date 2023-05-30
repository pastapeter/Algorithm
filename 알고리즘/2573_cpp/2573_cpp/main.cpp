//
//  main.cpp
//  2573_cpp
//
//  Created by Jung peter on 5/24/23.
//

#include <iostream>
#include <vector>
#include <deque>
using namespace std;

int n, m; // n->행, m->열 3 ~ 300
int map[301][301];
int dx[4] = {-1, 1, 0, 0};
int dy[4] = {0, 0, -1, 1};
int iceCnt = 0;
int year = 0;
pair<int, int> icestart;

bool check(int x, int y) {
  return (x>=0 && x< m && y>=0 && y<n);
}

void melt() {
  int newMap[301][301] = { 0 };
  for(int y=0;y<n;y++) {
    for(int x=0;x<m;x++) {
      if (map[y][x] != 0) {
        int temp = map[y][x];
        for(int i=0;i<4;i++) {
          int nx = x + dx[i];
          int ny = y + dy[i];
          if (!check(nx, ny)) continue;
          if (map[ny][nx] == 0) {
            if (temp == 0) {
              break;
            }
            temp--;
          }
        }
        newMap[y][x] = temp;
      }
    }
  }
  for(int y=0;y<n;y++) {
    for(int x=0;x<m;x++) {
      map[y][x] = newMap[y][x];
    }
  }
}

void check_icestart() {
  iceCnt = 0;
  for(int y=0;y<n;y++) {
    for(int x=0;x<m;x++) {
      if (map[y][x] != 0) {
        iceCnt++;
        icestart = { x, y};
      }
    }
  }
}

int bfs(pair<int, int> start) {
  
  bool visited[301][301] = { false };
  deque<pair<int, int>> queue = { start };
  visited[start.second][start.first] = true;
  int cnt = 0;
  
  while (queue.size() != 0) {
    pair<int, int> poped = queue.front(); queue.pop_front();
    cnt++;
    for(int i=0;i<4;i++) {
      int nx = poped.first + dx[i];
      int ny = poped.second + dy[i];
      
      if (!check(nx, ny)) continue;
      if (map[ny][nx] != 0 && !visited[ny][nx]) {
        queue.push_back({nx, ny});
        visited[ny][nx] = true;
      }
    }
  }
  return cnt;
}

int main(int argc, const char * argv[]) {
  cin >> n >> m;
  for(int y=0;y<n;y++) {
    for(int x=0;x<m;x++) {
      cin >> map[y][x];
      if (map[y][x] != 0) iceCnt ++;
    }
  }
  
  while (iceCnt != 0) {
    check_icestart();
    if (bfs(icestart) != iceCnt) {
      if (iceCnt == 0 && bfs(icestart) == 1) {
        cout << 0;
        return 0;
      }
      cout << year;
      return 0;
    }
    
    melt();
    year++;
    
  }
  
  cout << year;
  
  return 0;
}
