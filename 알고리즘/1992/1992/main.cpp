//
//  main.cpp
//  1992
//
//  Created by Jung peter on 5/30/23.
//

#include <iostream>
#include <string>
#include <vector>
#include <unordered_set>
using namespace std;
// 모두 0이면 0
// 모두 1이면 1
//4사분면으로 나눔
//1,2,3,4 사분면순서?
int n;
int map[64][64];
string answer = "";

void solve(pair<int, int> start, int width) {
  if (width == 1) {
    answer += to_string(map[start.second][start.first]);
    return;
  }
  unordered_set<int> set;
  for(int y=start.second;y<start.second+width;y++) {
    for(int x=start.first;x<start.first+width;x++) {
      set.insert(map[y][x]);
    }
  }
  if (set.size() == 1) {
    if (set.find(1) != set.end()) {
      answer += "1";
    } else {
      answer += "0";
    }
    return;
  }
  
  answer += "(";
  solve(start, width/2);
  solve({start.first+width/2, start.second}, width/2);
  solve({start.first, start.second+width/2}, width/2);
  solve({start.first+width/2, start.second+width/2}, width/2);
  answer += ")";
  
}

int main(int argc, const char * argv[]) {
  cin >> n;
  unordered_set<int> set;
  for(int y=0;y<n;y++) {
    string temp;
    cin >> temp;
    for(int x=0;x<temp.size();x++) {
      map[y][x] = temp[x] - '0';
      set.insert(map[y][x]);
    }
  }
  
  if (set.size()==1) {
    cout << map[0][0];
  } else {
    solve({0,0}, n);
  }
  cout << answer;
  return 0;
}
