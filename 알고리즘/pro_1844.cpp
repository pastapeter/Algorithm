#include<vector>
#include<queue>
#include<iostream>
using namespace std;
int board[101][101];

int bfs(pair<int, int> start, int n, int m) {
    
    queue<pair<int, int>> q;
    q.push(start);
    int dx[4] = {1, -1, 0, 0};
    int dy[4] = {0, 0, 1, -1};
    
    while (q.size() != 0) {
        
        pair<int, int> now = q.front();
        q.pop();
        
        for(int i=0;i<4;i++) {
            int nx = now.first + dx[i];
            int ny = now.second + dy[i];
            
            if (nx < 0 || ny < 0 || nx >= n || ny >= m) {
                continue;
            }
            
            if ((board[ny][nx] != -1) && (board[ny][nx] == 1)) {
                pair<int, int> newCoor = make_pair(nx, ny);
                q.push(newCoor);
                board[ny][nx] = board[now.second][now.first] + 1;
            }   
        }
    }    
    
    if (board[m-1][n-1] == 1 || board[m-1][n-1] == -1) return -1;
    return board[m-1][n-1];
    
}

int solution(vector<vector<int> > maps)
{
    
    // maps를 board로 바꿔줄 때 벽을 -1로 바꿔줄 거임
    for(int y=0;y<maps.size();y++) {
        for (int x=0;x<maps[y].size();x++) {
            if (maps[y][x] == 0) board[y][x] = -1;
            else board[y][x] = maps[y][x];
        }
    }
        
    pair<int, int> start = make_pair(0,0);
    int answer = bfs(start, maps[0].size(), maps.size());
    
    
    return answer;
}