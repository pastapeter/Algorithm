//
//  main.cpp
//  5014_cpp
//
//  Created by Jung peter on 5/23/23.
//

#include <iostream>
#include <vector>
#include <deque>

using namespace std;
// 위로 u층 올라가기, 아래로 d층 내려가기
// 총 f층, 나는 s층, 목적지 g층
bool visited[2000001];
int answer = 10000000;

void bfs(pair<int, int> start, int target, int up, int down, int top) {
  int dfloor[2] = {up, -down};
  deque<pair<int, int>> queue = { start };
  visited[start.first] = true;
  
  while (queue.size() != 0) {
    
    pair<int, int> poped = queue.front(); queue.pop_front();
    if (poped.first == target) {
      answer = min(answer, poped.second);
    }
    
    for(int i=0;i<2;i++) {
      
      int nfloor = poped.first + dfloor[i];
      
      if (nfloor <= 0 || nfloor > top) continue;
      if (!visited[nfloor]) {
        queue.push_back({nfloor, poped.second+1});
        visited[nfloor] = true;
      }
      
    }
    
  }
}

int main(int argc, const char * argv[]) {
  int f, s, g, u, d;
  cin >> f >> s >> g >> u >> d;
  bfs({s, 0}, g, u, d, f);
  if (answer == 10000000) cout << "use the stairs";
  else cout << answer;
  return 0;
}
