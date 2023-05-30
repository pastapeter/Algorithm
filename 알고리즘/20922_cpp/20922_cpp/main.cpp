//
//  main.cpp
//  20922_cpp
//
//  Created by Jung peter on 5/27/23.
//

#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;
int n, k;
vector<int> list;

//같은 원소가 여러개 X
//최장 연속? 투포인터
// 2개 이하
// 3 2 5 5 6 4 4 5 7

// end index를 늘렸을때 만약 k보다 커졌다면, start를 올려야하는 상황
// 그래서 end index의 숫자를 visited[숫자]로 하고.
// start 가 end index의 숫자를 넘어가는 순간
// answer를 찾고
// 다시 end를 높힐 수 있음

int visited[2000001] = { 0 };
int main(int argc, const char * argv[]) {
  cin >> n >> k;
  for(int i=0;i<n;i++) {
    int temp;
    cin >> temp;
    list.push_back(temp);
  }
  int start = 0, end = -1;
  bool flag = false;
  int answer = 0;
  vector<int> outboundList;
  int shouldfind = -1;
  while(start < n-1 && end < n-1) {
    if (!flag) {
      if (end < n-1) {
        end ++;
        visited[list[end]]++;
        if (visited[list[end]] > k) {
          shouldfind = list[end];
          flag = true;
        }
      }
    } else {
      visited[list[start]]--;
      if (list[start] == shouldfind && visited[list[start]] <= k) {
        flag = false;
      }
      start++;
    }
    if (!flag) {
      answer = max(answer, end-start+1);
    }
  }
  
  cout << answer;
  return 0;
}
