//
//  main.cpp
//  2839_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <vector>
using namespace std;
int n;
int options[2] = { 3, 5 };
int answer = 5000;
int dp[5001];

void dfs(int weight, vector<int> v) {
  if (weight >= n) {
    if (weight == n) {
      int cnt = v.size();
      answer = min(answer, cnt);
    }
    return;
  }
  for(int i=0;i<2;i++) {
    v.push_back(options[i]);
    dfs(weight+options[i], v);
    v.pop_back();
  }
}

void solve() {
  dp[3] = 1;
  dp[5] = 1;
  for(int i=6;i<=n;i++) {
    if (dp[i-3] != 0 && dp[i-5] != 0) {
      dp[i] = min(dp[i-3]+1, dp[i-5]+1);
    } else if(dp[i-3] != 0) {
      dp[i] = dp[i-3]+1;
    } else if(dp[i-5] != 0) {
      dp[i] = dp[i-5]+1;
    }
  }
}

int main(int argc, const char * argv[]) {
  cin >> n;
  solve();
  if (dp[n] == 0) {
    cout << -1;
  } else {
    cout << dp[n];
  }
  return 0;
}
