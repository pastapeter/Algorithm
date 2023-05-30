//
//  main.cpp
//  1446_2_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <vector>
using namespace std;
int n, d;
int dp[10001] = { 0 };
vector<vector<pair<int, int>>> shortcuts;

int main(int argc, const char * argv[]) {
  cin >> n >> d;
  for(int i=0;i<10001;i++) {
    dp[i] = i;
  }
  shortcuts.resize(100001, vector<pair<int, int>>());
  for(int i=0;i<n;i++) {
    int from, to, weight;
    cin >> from >> to >> weight;
    shortcuts[to].push_back({ from, weight});
  }
  
  for(int i=0;i<=d;i++) {
    if(!shortcuts[i].empty()) {
      for(auto info:shortcuts[i]) {
        dp[i] = min(dp[i], min(dp[i-1]+1, dp[info.first] + info.second));
      }
    } else {
      dp[i] = min(dp[i], dp[i-1]+1);
    }
  }
  
  cout << dp[d] << endl;
  return 0;
}
