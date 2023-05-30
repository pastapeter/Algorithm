//
//  main.cpp
//  2667_cpp
//
//  Created by Jung peter on 5/23/23.
//

#include <iostream>
#include <vector>
#include <deque>
#include <algorithm>
using namespace std;

int dx[4] = {1,-1,0,0};
int dy[4] = {0,0,1,-1};
bool visited[26][26];
int map[26][26];
int n;
int answer;
vector<int> result;

struct Coor {
  int x;
  int y;
};

int bfs(Coor start) {
  
  deque<Coor> queue = { start };
  visited[start.y][start.x] = true;
  int num = 0;
  while (queue.size() != 0) {
    
    Coor poped = queue.front();
    queue.pop_front();
    num++;
    
    for(int i=0;i<4;i++) {
      int nx = poped.x + dx[i];
      int ny = poped.y + dy[i];
      
      if (nx < 0 || nx >= n || ny < 0 || ny >= n) continue;
      if (map[ny][nx] != 0 && !visited[ny][nx]) {
        Coor newCoor;
        newCoor.x = nx;
        newCoor.y = ny;
        queue.push_back(newCoor);
        visited[ny][nx] = true;
      }
      
    }
    
  }
  return num;
}


int main(int argc, const char * argv[]) {
  cin >> n;
  for(int y=0;y<n;y++) {
    string row;
    cin >> row;
    for(int x=0;x<n;x++) {
      map[y][x] = row[x]-'0';
    }
  }
  
  for(int y=0;y<n;y++) {
    for(int x=0;x<n;x++) {
      if (map[y][x] == 1 && !visited[y][x]) {
        Coor start;
        start.x = x;
        start.y = y;
        answer++;
        result.push_back(bfs(start));
      }
    }
  }
  
  cout << answer << endl;
  sort(result.begin(), result.end());
  for(auto i:result) {
    cout << i << endl;
  }
  return 0;
}
