//
//  main.cpp
//  2531_cpp
//
//  Created by Jung peter on 5/25/23.
//

#include <iostream>
#include <vector>
#include <deque>
#include <unordered_map>
using namespace std;

int N, d, k, c; // 접시수, 초밥 종류, 연속, 쿠폰
vector<int> sushis;
unordered_map<int, int> eat;
int answer = 0;

int main(int argc, const char * argv[]) {
  cin >> N >> d >> k >> c;
  for(int i=0;i<N;i++) {
    int temp;
    cin >> temp;
    sushis.push_back(temp);
  }
  eat.insert({c, 1});
  for(int i=0;i<N;i++) {
    if (i==0) {
      for(int j=0;j<k;j++) {
        if(eat.find(sushis[j]) != eat.end()) {
          eat[sushis[j]]++;
        } else {
          eat.insert({sushis[j], 1});
        }
      }
    } else { //0123, 1234
      if (eat[sushis[i-1]] > 1) {
        eat[sushis[i-1]]--;
      } else {
        eat.erase(sushis[i-1]);
      }
      if(eat.find(sushis[(i+k-1)%N]) != eat.end()) {
        eat[sushis[(i+k-1)%N]]++;
      } else {
        eat.insert({sushis[(i+k-1)%N], 1});
      }
    }
    int maxSize = eat.size();
    answer = max(answer, maxSize);
  }
  
  cout << answer;
  return 0;
}
