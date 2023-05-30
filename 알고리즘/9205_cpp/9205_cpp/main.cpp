//
//  main.cpp
//  9205_cpp
//
//  Created by Jung peter on 5/24/23.
//

#include <iostream>
#include <vector>
#include <deque>
#include <cmath>
using namespace std;

//편의점 들리면 1000미터 갈수 있음
//
int dist(pair<int, int> lhs, pair<int, int> rhs) {
  return abs(lhs.first - rhs.first) +abs(lhs.second - rhs.second);
}

bool bfs(vector<pair<int, int>> points, int n) {
  bool visited[101] = {false};
  deque<int> queue = { 0 };
  visited[0] = true;
  bool canGo = false;
  
  while (queue.size() != 0) {
    
    int poped = queue.front(); queue.pop_front();
    
    if (poped == n+1) {
      canGo = true;
    }
    
    for(int i=0;i<points.size();i++) {
      if (dist(points[poped], points[i]) <= 1000 && !visited[i]) {
        queue.push_back(i);
        visited[i] = true;
      }
    }
    
  }
  return canGo;
}

int main(int argc, const char * argv[]) {
  int t;
  cin >> t;
  for(int i=0;i<t;i++) {
    int n;
    cin >> n;
    vector<pair<int, int>> point;
    for(int j=0;j<n+2;j++) {
      int x, y;
      cin >> x >> y;
      point.push_back({x, y});
    }
    if (bfs(point, n)) {
      cout << "happy" << endl;;
    } else {
      cout << "sad" << endl;
    };
  }
  return 0;
}
