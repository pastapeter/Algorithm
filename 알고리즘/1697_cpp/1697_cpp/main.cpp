//
//  main.cpp
//  1697_cpp
//
//  Created by Jung peter on 5/23/23.
//

#include <iostream>
#include <vector>
#include <deque>
using namespace std;

int answer = 10000001;
bool visited[200001];

void dfs(int start, int target, int num) {
  
  if (start == target) {
    answer = min(answer, num);
  }
  if (start < 0 || start > 100000 ) {
    return;
  }
  if (visited[start] == true) {
    return;
  }
  dfs(start-1, target, num+1);
  dfs(start+1, target, num+1);
  dfs(start*2, target, num+1);
}

void bfs(pair<int, int> start, int target) {
  
  deque<pair<int, int>> queue = { start };
  visited[start.first] = true;
  
  while (queue.size() != 0) {
    pair<int, int> poped = queue.front();
    queue.pop_front();
    
    if (poped.first == target) {
      answer = min(answer, poped.second);
    }
    
    for(int i=0;i<3;i++) {
      int newlocation;
      if (i == 0) {
        newlocation = poped.first + 1;
      } else if (i == 1) {
        newlocation = poped.first - 1;
      } else {
        newlocation = poped.first * 2;
      }
      
      if (newlocation < 0 || newlocation > 200000) continue;
      if (!visited[newlocation]) {
        queue.push_back(make_pair(newlocation, poped.second+1));
        visited[newlocation] = true;
      }
      
    }
    
  }
  
}

int main(int argc, const char * argv[]) {
  int start, target;
  cin >> start >> target;
  bfs(make_pair(start, 0), target);
  cout << answer;
  return 0;
}
