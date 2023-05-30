//
//  main.cpp
//  11501_cpp
//
//  Created by Jung peter on 5/27/23.
//

#include <iostream>
#include <vector>
#include <deque>
using namespace std;

// 3가지 중 1개
// 주식을 산다, 주식을 판다, 아무것도 안한다.

// 그리디임
// 주식을 뒤에서 부터 확인한다.
// 가장 마지막날을 max 라고 두고,
// 그이후에 뒤에서부터 하나씩 보면서
// max보다 작은 경우 max에서 해당 값을 뺸걸 더하고
// max보다 큰 경우, max를 갱신시켜주면댐

int T;
vector<int> stocks;
vector<long long> answers;
int n;

int main(int argc, const char * argv[]) {
  ios_base::sync_with_stdio(0);
  cin >> T;
  for(int i=0;i<T;i++) {
    stocks.clear();
    long long answer = 0;
    cin >> n;
    for(int j=0;j<n;j++) {
      int temp;
      cin >> temp;
      stocks.push_back(temp);
    }
    int max = stocks.back();
    for(int i=stocks.size() - 2; i >= 0;i--) {
      if (stocks[i] > max) max = stocks[i];
      else answer += (max - stocks[i]);
    }
    answers.push_back(answer);
  }
  for(auto ans:answers) {
    cout << ans << endl;
  }
  return 0;
}
