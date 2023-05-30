//
//  main.cpp
//  22251_cpp
//
//  Created by Jung peter on 5/27/23.
//

#include <iostream>
#include <vector>
#include <numeric>
#include <algorithm>
using namespace std;

int led[10][7] = {
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
int changeNum[10][10] = { 0 };
// 최소 1개 최대 p
// k는 숫자갯수
// 1 이상 n이하
// 실제로 x층
int n, k, p, x;
string str;

int dfs(int depth, int cnt) {
  if (depth >= str.length()) {
    if (stoi(str) == x) return 0;
    if (stoi(str) <= n && stoi(str) >= 1) return 1;
    return 0;
  }
  
  //led 갯수
  int sum = 0;
  //현재 LED
  int cur = str[depth] - '0';
  
  for(int i=0;i<10;i++) {
    //같은 걸로 변신 아니고 && 변신하는데 cnt보다 작다
    if(cur != i && changeNum[cur][i] <= cnt) {
      // 변신
      str[depth] = i + '0';
      // dfs(다음 자리수, 남은 led 변화갯수)
      sum += dfs(depth+1, cnt-changeNum[cur][i]);
      // 변신안함
      str[depth] = cur + '0';
    }
    // 그리고 변신안했다면, 그냥 다음 차례
    if(cur == i) sum += dfs(depth+1, cnt);
  }
  return sum;
}

int main(int argc, const char * argv[]) {
  cin >> n >> k >> p >> x;
  for(int y=0;y<10;y++) {
    for(int x=0;x<10;x++) {
      for(int i=0;i<7;i++) {
        if (led[y][i] - led[x][i] != 0) {
          changeNum[y][x]++;
        }
      }
    }
  }
  
  str = to_string(x);
  while(str.length() < k) str.insert(str.begin(), '0');

  cout << dfs(0, p);
    
  return 0;
}


