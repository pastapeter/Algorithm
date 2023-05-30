//
//  main.cpp
//  2178_cpp
//
//  Created by Jung peter on 5/23/23.
//

#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <deque>
using namespace std;

int n;
int m;
bool visited[101][101];
int map[101][101];
int dx[4] = {1,-1,0,0};
int dy[4] = {0,0,1,-1};
int answer = 100001;

struct Coor {
  int x;
  int y;
  int count;
};

void bfs(Coor start) {
  
  deque<Coor> queue = {start};
  visited[start.y][start.x] = true;
  
  while (queue.size() != 0) {
    
    int x = queue.front().x;
    int y = queue.front().y;
    int count = queue.front().count;
    queue.pop_front();
    
    if (x == m-1 && y == n-1) {
      answer = min(answer, count);
    }
    
    for(int i=0;i<4;i++) {
      
      int nx = x + dx[i];
      int ny = y + dy[i];
      
      if (nx >= m || nx < 0 || ny >= n || ny < 0) continue;
      
      if (map[ny][nx] == 1 && !visited[ny][nx]) {
        Coor newCoor;
        newCoor.x = nx;
        newCoor.y = ny;
        newCoor.count = count+1;
        queue.push_back(newCoor);
        visited[ny][nx] = true;
      }
      
    }
    
  }
  
}



int main(int argc, const char * argv[]) {
  cin >> n >> m;
  for(int y=0;y<n;y++) {
    string temp;
    cin >> temp;
    for (int x=0;x<m;x++) {
      map[y][x] = (temp[x]-'0');
    }
  }
  Coor start;
  start.x = 0;
  start.y = 0;
  start.count = 1;
  bfs(start);
  cout << answer;
  return 0;
}
