//
//  main.cpp
//  176963_programmers
//
//  Created by Jung peter on 5/22/23.
//

#include<vector>
#include<deque>
#include<iostream>

using namespace std;

int dx[4] = {1,-1, 0, 0};
int dy[4] = {0, 0, 1, -1};
int n;
int m;
bool visited[101][101];
vector<vector<int>> map;

struct coor {
    int x;
    int y;
    int count;
};

void bfs(coor start) {
    
    visited[start.y][start.x] = true;
    deque<coor> queue = {start};
    
    while (!queue.size()) {
        
        int x = queue.front().x;
        int y = queue.front().y;
        int cnt = queue.front().cnt;
        queue.pop_front();
      
        for(int i=0;i<4;i++) {
            
            int nx = x + dx[i];
            int ny = y + dy[i];
            
            if (map[ny][nx] == 0) continue ;
            if (nx >= n || nx < 0 || ny < 0 || ny >= m) continue;
            if (!visited[ny][nx]) {
              coor newcoor;
              newcoor.x = nx; newcoor.y = ny; newcoor.count = cnt+1;
              queue.push_back(newcoor);
            }
        }
        
    }
    
}

int solution(vector<vector<int> > maps)
{
    int answer = 0;
    return answer;
}

int main(int argc, const char * argv[]) {
  
  return 0;
}
