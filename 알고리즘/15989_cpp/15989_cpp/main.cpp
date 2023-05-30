//
//  main.cpp
//  15989_cpp
//
//  Created by Jung peter on 5/28/23.
//

#include <iostream>
#include <vector>
#include <algorithm>
//중복을 피하기위해 오름차순으로만 더한다는 것이 중요함
using namespace std;
int T, n;
int dp[10001][4];

void solution() {
  dp[0][1] = 1;
  dp[1][1] = 1;
  for(int i=2;i<=10000;i++) {
    dp[i][1] = dp[i-1][1];
    dp[i][2] = dp[i-2][1] + dp[i-2][2];
    if(i >= 3) {
      dp[i][3] = dp[i-3][1] + dp[i-3][2] + dp[i-3][3];
    }
  }
}

int main(int argc, const char * argv[]) {
  ios_base::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);
  cin >> T;
  solution();
  for(int i=0;i<T;i++) {
    cin >> n;
    cout << dp[n][1] + dp[n][2] + dp[n][3] << "\n";
  }
  return 0;
}
