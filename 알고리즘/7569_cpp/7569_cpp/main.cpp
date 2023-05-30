//
//  main.cpp
//  7569_cpp
//
//  Created by Jung peter on 5/23/23.
//

#include <iostream>
#include <deque>
#include <vector>

using namespace std;

int map[101][101][101];
int H;
int M;
int N;
int dx[6] = { -1, 1, 0, 0, 0, 0};
int dy[6] = { 0, 0, 1, -1, 0 ,0};
int dz[6] = { 0, 0, 0, 0, 1, -1};
deque<vector<int>> queue;
int answer = 0;

void bfs() {

  while (queue.size() != 0) {
    
    vector<int> poped = queue.front(); queue.pop_front();
    
    for(int i=0;i<6;i++) {
      //여기는 같은층
      int nx = poped[0] + dx[i];
      int ny = poped[1] + dy[i];
      int nz = poped[2] + dz[i];
      
      if(nx < 0 || nx >= M || ny < 0 || ny >= N || nz < 0 || nz >= H) continue;
      if(map[nz][ny][nx] == 0) {
        queue.push_back({nx, ny, nz});
        map[nz][ny][nx] = map[poped[2]][poped[1]][poped[0]] + 1;
      }
      
    }

  }
  
}

int main(int argc, const char * argv[]) {
  cin >> M >> N >> H;
  vector<vector<int>> tomatos;
  int unmatured = 0;
  for(int z=0;z<H;z++) {
    for(int y=0;y<N;y++) {
      for(int x=0;x<M;x++) {
        cin >> map[z][y][x];
        if (map[z][y][x] == 1) {
          queue.push_back({x,y,z});
        } else if (map[z][y][x] == 0) {
          unmatured++;
        }
      }
    }
  }
  if (unmatured == 0) {
    cout << 0;
    return 0;
  }
  
  bfs();
  for(int z=0;z<H;z++) {
    for(int y=0;y<N;y++) {
      for(int x=0;x<M;x++) {
        answer = max(answer, map[z][y][x]);
        if (map[z][y][x] == 0) {
          cout << -1;
          return 0;
        }
      }
    }
  }
  cout << answer-1;
  return 0;
}
