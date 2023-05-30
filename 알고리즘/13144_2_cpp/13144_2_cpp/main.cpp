//
//  main.cpp
//  13144_2_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <vector>
using namespace std;
int n; // 100000 -> n^2은 안됌
vector<int> list;
bool visited[100001] = { false };

int main(int argc, const char * argv[]) {
  cin >> n;
  for(int i=0;i<n;i++) {
    int temp;
    cin >> temp;
    list.push_back(temp);
  }
  int end = 0;
  int start = 0;
  long long answer = 0;
  /*
   end index를 갈수있는곳까지 보낸다.
   그리고 더이상가지 못할때 (end < n 이거나 visited[list[end]] == true일 경우)
   1 2 3 1 2 일경우,
   123까지 갔을때, end-start가 경우의수 개수이다. 이거 알아두자
   할튼 더이상 가지 못할때, start index를 ++ 해준다.
   start ++를 하더라도 visited[list[end]]가 true라면 또 start++ 해줘야할 것임
   */
  while(start < n) {
    while(end < n) {
      if (visited[list[end]]) break;
      visited[list[end]] = true;
      end++;
    }
    answer += end - start;
    visited[list[start]] = false;
    start++;
  }
  cout << answer << endl;
  return 0;
}
