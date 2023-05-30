//
//  main.cpp
//  2630_cpp
//
//  Created by Jung peter on 5/30/23.
//

#include <iostream>
#include <vector>
#include <unordered_set>
using namespace std;
int n;
int map[128][128];

//전체 종이가 같은색이 아니면
// n/2 * n/2로 나눈다 (4개)
// 동일하게함
// 잘라진 종이가 모두 하얀색, 또는 파란색
// 1칸이 되었을때?
int bluecnt = 0;
int whitecnt = 0;

void solve(pair<int, int> start, int width) {
  if (width == 1) {
    if (map[start.second][start.first] == 1) {
      bluecnt++;
    } else {
      whitecnt++;
    }
    return;
  }
  
  unordered_set<int> set;
  for(int y=start.second;y<start.second+width;y++) {
    for(int x=start.first;x<start.first+width;x++) {
      set.insert(map[y][x]);
    }
  }
  
  if (set.size() == 1) {
    if(set.find(1) == set.end()) {
      whitecnt++;
    } else {
      bluecnt++;
    }
    return;
  }
  
  solve(start, width/2);
  solve({start.first, start.second+width/2}, width/2);
  solve({start.first+width/2, start.second}, width/2);
  solve({start.first+width/2, start.second+width/2}, width/2);
  

}


int main(int argc, const char * argv[]) {
  cin >> n;
  for(int y=0;y<n;y++){
    for(int x=0;x<n;x++) {
      cin >> map[y][x];
    }
  }
  solve({0, 0}, n);
  cout << whitecnt << endl;
  cout << bluecnt << endl;
  return 0;
}
