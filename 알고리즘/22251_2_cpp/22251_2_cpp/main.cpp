//
//  main.cpp
//  22251_2_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

vector<vector<int>> numbers = {
  {1,1,0,1,1,1,1},
  {0,0,0,1,0,0,1},
  {1,0,1,1,1,1,0},
  {1,0,1,1,0,1,1},
  {0,1,1,1,0,0,1},
  {1,1,1,0,0,1,1},
  {1,1,1,0,1,1,1},
  {1,0,0,1,0,0,1},
  {1,1,1,1,1,1,1},
  {1,1,1,1,0,1,1}
};

int weight[10][10] = { 0 };
int N, K, P, X;
string str;
// LED변경은 1 ~ P
// 변경된 숫자는 1 ~ N 사이이다.
// 초기값은 X임
// K는 보이는 숫자

/*
틀린 포인트는
 while(str.length() < K) str.insert(str.begin(), '0'); 의 유무가 중요함
 보이는 숫자 갯수가 2일때, 5가 x로들어온다면
 05로 바꾸어줘야한다.
 */
int answer = 0;
void dfs(int depth, int ledCnt, string temp) {
  if (depth >= str.length()) {
    if (stoi(temp) == X) return;
    if (stoi(temp) <= N && stoi(temp) >= 1) {
      answer++;
    }
    return;
  }
  int cur = temp[depth] - '0';
  for(int to=0;to<10;to++) {
    if(cur == to) dfs(depth+1, ledCnt, temp);
    else {
      int w = weight[cur][to];
      if(w > ledCnt) continue; //못바꾸는것
      // 바꿀수있다면
      temp[depth] = to + '0';
      dfs(depth+1, ledCnt-w, temp);
      temp[depth] = cur + '0';
    }
  }
  
}

int main(int argc, const char * argv[]) {
  cin >> N >> K >> P >> X;
  // 바꾸는데 필요한 weight
  for(int from=0;from<10;from++) {
    for(int to=0;to<10;to++) {
      for(int i=0;i<7;i++) {
        if (numbers[from][i] != numbers[to][i]) {
          weight[from][to]++;
        }
      }
    }
  }
  str = to_string(X);
  while(str.length() < K) str.insert(str.begin(), '0');
  dfs(0, P, str);
  cout << answer << endl;
  return 0;
}
