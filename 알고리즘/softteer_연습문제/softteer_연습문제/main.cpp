//
//  main.cpp
//  softteer_연습문제
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <vector>
#include <deque>
using namespace std;
int n;
int map[11][11];
int dx[4] = { -1, 1, 0 ,0};
int dy[4] = {0,0,1,-1};
bool visited[11][11];

int bfs(pair<int, int> start) {
  deque<pair<int, int>> queue = { start };
  visited[start.second][start.first] = true;
  int cnt = 0;
  while( queue.size() != 0) {
    pair<int, int> poped = queue.front(); queue.pop_front();
    cnt++;
    for(int i=0;i<4;i++) {
      int nx = poped.first + dx[i];
      int ny = poped.second + dy[i];
      
      if (nx < 0 || nx >= n || ny < 0 || ny >= n) continue;
      if (map[ny][nx] == 1 && !visited[ny][nx]) {
        visited[ny][nx] = true;
        queue.push_back({nx, ny});
      }
    }
    
  }
  return cnt;
}

int main(int argc, const char * argv[]) {
  cin >> n;
  for(int y=0;y<n;y++) {
    for(int x=0;x<n;x++) {
      cin >> map[y][x];
    }
  }
  int cnt = 0;
  vector<int> answer;
  for(int y=0;y<n;y++) {
    for(int x=0;x<n;x++) {
      if (map[y][x] == 1 && !visited[y][x]) {
        cnt++;
        answer.push_back(bfs({x ,y}));
      }
    }
  }
  
  cout << cnt << endl;
  for(auto ans: answer) {
    cout << ans << " ";
  }
  
  return 0;
}
