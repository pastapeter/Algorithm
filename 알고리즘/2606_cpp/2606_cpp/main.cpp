//
//  main.cpp
//  2606_cpp
//
//  Created by Jung peter on 5/23/23.
//

#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <set>
#include <deque>
using namespace std;

int num;
int line;
vector<vector<int>> network;
set<int> visited;
int answer;

void bfs() {
  
  deque<int> queue = {1};
  visited.insert(1);
  
  while (queue.size() != 0) {
    
    int cur = queue.front();
    queue.pop_front();
    
    vector<int> candidates = network[cur];
    for(auto i:candidates) {
      if (visited.find(i) == visited.end()) {
        queue.push_back(i);
        answer++;
        visited.insert(i);
      }
    }
  }
}

int main(int argc, const char * argv[]) {
  cin >> num;
  cin >> line;
  for(int i=0;i<=num;i++) {
    network.push_back({});
  }
  for(int i=0;i<line;i++) {
    int from, to;
    cin >> from >> to;
    network[from].push_back(to);
    network[to].push_back(from);
  }
  bfs();
  cout << answer;
  return 0;
}
