//
//  main.cpp
//  17144_cpp
//
//  Created by Jung peter on 5/28/23.
//

#include <iostream>
#include <cmath>
#include <vector>
#include <algorithm>
using namespace std;
int map[51][51] = { 0 };
int R, C, T;
int dx[4] = { -1, 1, 0, 0};
int dy[4] = { 0, 0, -1, 1};

// 미세먼지가 확산될때는 미세먼지가 있는 모든 칸에서 동시에 일어남
// 확신되는 양은 floor(map[y][x] / 5)임
// map[y][x] -= floor(map[y][x] / 5) * 날라간 방향 갯수

bool check(int x, int y) {
  return x >= 0 && x < C && y >=0 && y < R;
}

void spread(vector<pair<int, int>> starts) {
  int newMap[51][51] = { 0 };
  for(auto coor: starts) {
    int cur = map[coor.second][coor.first];
    int dust = floor(cur/5);
    if (dust > 0) {
      for(int i=0;i<4;i++) {
        int nx = coor.first + dx[i];
        int ny = coor.second + dy[i];
        
        if (check(nx, ny) && map[ny][nx] != -1) {
          newMap[ny][nx] += dust;
          cur -= dust;
        }
       }
    }
    newMap[coor.second][coor.first] += cur;
  }
  
  for(int y=0;y<51;y++) {
    for(int x=0;x<51;x++) {
      if (map[y][x] != -1) map[y][x] = newMap[y][x];
    }
  }
}

// 공기청정기 작동
// 위는 반시계, 아래는 시계
// 바람이 불면 방향대로 모두 한칸씩이동
// 공기청정기에 부딫힌 먼지는 0?
void airPure(pair<int, int> start, bool up) {
  int newMap[51][51] = { 0 };
  for(int y=0;y<51;y++) {
    for(int x=0;x<51;x++) {
      newMap[y][x] = map[y][x];
    }
  }
  if (up) {
    //좌 -> 우
    for(int x=0;x<C-1;x++) {
      if (map[start.second][x] == -1) newMap[start.second][x+1] = 0;
      else { newMap[start.second][x+1] = map[start.second][x]; }
    }
    // 위
    for(int y=start.second;y>0;y--) {
      newMap[y-1][C-1] = map[y][C-1];
    }
    // 우 -> 좌
    for(int x=C-1;x>0;x--) {
      newMap[0][x-1] = map[0][x];
    }
    // 아래
    for(int y=0;y<start.second-1;y++) {
      newMap[y+1][0] = map[y][0];
    }
    
  } else {
    //좌
    for(int x=0;x<C-1;x++) {
      if (map[start.second][x] == -1) newMap[start.second][x+1] = 0;
      else newMap[start.second][x+1] = map[start.second][x];
    }
    
    //우
    for(int x=C-1;x>0;x--) {
      newMap[R-1][x-1] = map[R-1][x];
    }
    
    for(int y=start.second;y<R-1;y++) {
      newMap[y+1][C-1] = map[y][C-1];
    }
    
    for(int y=R-1;y>start.second+1;y--) {
      newMap[y-1][0] = map[y][0];
    }
    
  }
  for(int y=0;y<51;y++) {
    for(int x=0;x<51;x++) {
      map[y][x] = newMap[y][x];
    }
  }
}


int main(int argc, const char * argv[]) {
  cin >> R >> C >> T;
  for(int y=0;y<R;y++) {
    for(int x=0;x<C;x++) {
      cin >> map[y][x];
    }
  }
  while(T--) {
    vector<pair<int, int>> dustCoors;
    vector<pair<int, int>> airPurifier;
    for(int y=0;y<R;y++) {
      for(int x=0;x<C;x++) {
        if (map[y][x] == -1) {
          airPurifier.push_back({ x, y});
        }
        else if (map[y][x] != 0 && map[y][x] != -1) {
          dustCoors.push_back({x, y});
        }
      }
    }
    
    spread(dustCoors);
    airPure(airPurifier[0], true);
    airPure(airPurifier[1], false);
  }
  int answer = 0;
  for(int y=0;y<R;y++) {
    for(int x=0;x<C;x++) {
      if (map[y][x] != -1) answer+= map[y][x];
    }
  }
  cout << answer << endl;
  return 0;
}
