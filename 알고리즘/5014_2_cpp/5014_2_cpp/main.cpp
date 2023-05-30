//
//  main.cpp
//  5014_2_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <vector>
#include <deque>
#include <algorithm>
using namespace std;
int f, s, g, u, d;
// f는 총 층
// s는 현재 층 - start
// g는 가려고 하는 층 - target
// u버튼 위로가는 u
// d 아래로
bool visited[1000001] = { false };
int answer = 2000002;
void bfs() {
  deque<pair<int, int>> queue = { {s, 0} };
  visited[s] = true;
  while (queue.size() != 0) {
    pair<int, int> poped = queue.front(); queue.pop_front();
    if (poped.first == g) {
      answer = min(answer, poped.second);
    }
    for(int i=0;i<2;i++) {
      int ns;
      if (i==0) {
        ns = poped.first + u;
      } else {
        ns = poped.first - d;
      }
      if (ns > f || ns < 1) continue;
      if (!visited[ns]) {
        visited[ns] = true;
        queue.push_back({ns, poped.second+1});
      }
    }
  }
}

int main(int argc, const char * argv[]) {
  cin >> f >> s >> g >> u >> d;
  bfs();
  if (answer == 2000002) cout << "use the stairs";
  else cout << answer;
  return 0;
}
