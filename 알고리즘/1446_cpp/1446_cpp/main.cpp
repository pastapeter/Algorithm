//
//  main.cpp
//  1446_cpp
//
//  Created by Jung peter on 5/27/23.
//

#include <iostream>
#include <vector>
using namespace std;
int n, d;
vector<vector<pair<int, int>>> map;

//완탐같음
//DP + 다익스트라
/*
 일단 최단거리 + weight이 있다면 다익스트라를 먼저 생각해보기
 다익스트라를 생각했을때, Graph를 만들때, 다익스트라의 식을 생각해보기
 현재까지 오는데 최단거리 = dist[i] = dist[i](기존), min(dist[i-1] + 1(전에서 1키로 온거), dist[지름길루트 출발지점] + 지름길 길이)
 지름길루트 출발지점을 dist의 인자로 잡고 싶고, 도착하는곳을 for문 돌고 있기때문에
 애초에 그래프만들때, map[도착지점] = {{출발지점, weight} ,.. }
 for( auto {출발지점, weight} : map[도착지점]) 했을떄
 dist[출발지점] + weight, dist[도착지점], dist[도착지점-1] + 1 중에 min을 고를 수 있음
 */

int main(int argc, const char * argv[]) {
  cin >> n >> d;
  // 지름길 시작 위치, 도착 위치, 지름길의 길이
  for(int i=0;i<=d;i++) {
    map.push_back(vector<pair<int, int>>());
  }
  vector<int> dist(d+1, INT_MAX);
  int from, to, w;
  for(int i=0;i<n;i++) {
    cin >> from >> to >> w;
    map[to].push_back({ from, w });
  }
  
  dist[0] = 0;
  for(int i=1;i<=d;i++) {
    if(map[i].size() == 0) dist[i] = dist[i-1]+1;
    else {
      for(auto destination: map[i]) {
        dist[i] = min(dist[i], min(dist[i-1] + 1, dist[destination.first] + destination.second));
      }
    }
  }
  cout << dist[d] << endl;
  return 0;
}
