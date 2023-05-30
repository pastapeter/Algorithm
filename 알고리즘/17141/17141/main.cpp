//
//  main.cpp
//  17141
//
//  Created by Jung peter on 5/26/23.
//
#include <iostream>
#include <vector>
#include <deque>
#include <algorithm>
using namespace std;

int m; //바이러스 개수
int n; //연구소크기
int map[51][51];
int dx[4] = { -1, 1, 0 , 0};
int dy[4] = {0,0,1,-1};
vector<pair<int, int>> candidates;
vector<vector<pair<int, int>>> viruses;
vector<int> answers;
// 0 빈칸, 1 벽, 2 바이러스 가능
// -1 빈칸, 1 벽, 2 바이러스 가능

 void ncr(vector<pair<int, int>> answer, int target, int depth) {
  if (depth == candidates.size()) {
    if (answer.size() == target) {
      viruses.push_back(answer);
    }
    return;
  }
   answer.push_back(candidates[depth]);
   ncr(answer, target, depth+1);
   answer.pop_back();
   ncr(answer, target, depth+1);
}

int bfs(vector<pair<int, int>> start) {
  int newMap[51][51] = { 0 };
  bool visited[51][51] = { false };
  copy(&map[0][0], &map[0][0]+51*51, &newMap[0][0]);
  deque<pair<int, int>> queue(start.begin(), start.end());
  for(auto candidate: candidates) {
    newMap[candidate.second][candidate.first] = 0;
  }
  for(auto loc: start) {
    visited[loc.second][loc.first] = true;
    newMap[loc.second][loc.first] = 0;
  }
  
  
  while (queue.size() != 0) {
    
    pair<int, int> poped = queue.front(); queue.pop_front();
    
    for(int i=0;i<4;i++) {
      int nx = poped.first + dx[i];
      int ny = poped.second + dy[i];
      
      if(nx < 0 || nx >= n || ny < 0 || ny >= n) continue;
      if(newMap[ny][nx] == 0 && !visited[ny][nx]) {
        newMap[ny][nx] = newMap[poped.second][poped.first] + 1;
        visited[ny][nx] = true;
        queue.push_back({nx, ny});
      }
      
    }
    
  }
  int tempAnswer = -1;
  
  for(int y=0;y<n;y++) {
    for(int x=0;x<n;x++) {
      if (newMap[y][x] == 0) {
        if (find(start.begin(), start.end(), make_pair(x, y)) == start.end()) {
          return 5000;
        }
      }
      tempAnswer = max(tempAnswer, newMap[y][x]);
    }
  }
  return tempAnswer;
}

int main(int argc, const char * argv[]) {
  cin >> n >> m;
  for(int y=0;y<n;y++) {
    for(int x=0;x<n;x++) {
      cin >> map[y][x];
      if (map[y][x] == 1) map[y][x] = -1;
      if (map[y][x] == 2) candidates.push_back({x, y});
    }
  }
  ncr(vector<pair<int, int>>(), m, 0);
  for( auto start: viruses) {
    int temp = bfs(start);
    answers.push_back(temp);
  }
  
  int answer = *min_element(answers.begin(), answers.end());
  if (answer == 5000) cout << -1;
  else cout << answer;
  return 0;
}
