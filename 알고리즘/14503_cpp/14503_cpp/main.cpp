//
//  main.cpp
//  14503_cpp
//
//  Created by Jung peter on 5/23/23.
//

//현재칸이 청소되지 않은 경우, 청소한다.
//4칸 중 청소되지 않은 빈칸이 없는경우
// 바라보는 방향 유지 -> 한칸 후진 ->
// 후진못하면 작동을 멈춤
// 빈칸 있으면
// 반시계 90도 회전
//

#include <iostream>
#include <vector>
#include <deque>
#include <unordered_map>

using namespace std;

int n;
int m;
// 북 동 남 서
int dx[4] = {0,1,0,-1};
int dy[4] = {-1,0,1,0};
int map[51][51];
int answer = 0;

int backward(int dir) {
  unordered_map<int, int> back = {{0, 2}, {1,3}, {2,0}, {3,1}};
  return back[dir];
}

int opposeClockwise(int dir) {
  unordered_map<int, int> opposecw = {{0, 3}, {1,0}, {2,1}, {3,2}};
  return opposecw[dir];
}

bool check(int x, int y) {
  return (x >= 0 && x < m && y >=0 && y < n);
}

void robotbfs(pair<int, int> start, int dir) {
  
  int x = start.first;
  int y = start.second;
  
  // 1
  while (true) {
    
    if (map[y][x] == 0) {
      map[y][x] = -1;
      answer++;
    }
    
    // 2
    bool flag = false;
    for(int i=0;i<4;i++) {
      int nx = x + dx[(dir+i)%4];
      int ny = y + dy[(dir+i)%4];
      
      if (check(nx, ny) == false) continue;
      
      if (map[ny][nx] == 0) {
        flag = true;
        break;
      }
    }
    
    //2
    if (flag == false) {
      
      int nx = x + dx[backward(dir)];
      int ny = y + dy[backward(dir)];
      
      //2-2
      if (check(nx, ny) == false) return;
      if (map[ny][nx] == 1) return;
      x = nx;
      y = ny;
      
    } else {
      dir = opposeClockwise(dir);
      int nx = x + dx[dir];
      int ny = y + dy[dir];
      if (check(nx, ny) && map[ny][nx] == 0) {
        x = nx;
        y = ny;
      }
    }
  }
  
}

int main(int argc, const char * argv[]) {
  cin >> n >> m;
  int startx, starty, dir;
  cin >> starty >> startx >> dir;
  for(int y=0;y<n;y++) {
    for(int x=0;x<m;x++) {
      cin >> map[y][x];
    }
  }
  robotbfs({startx, starty}, dir);
  cout << answer;
  return 0;
}
