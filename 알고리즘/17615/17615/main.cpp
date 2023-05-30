//
//  main.cpp
//  17615
//
//  Created by Jung peter on 5/24/23.
//

#include <iostream>
#include <string>
#include <unordered_set>
using namespace std;

string input;
int answer = 500001;

void group(char x) {
  int cnt = 0;
  bool flag = false;
  for(int i=0;i<input.size();i++) {
    if (input[i] != x) flag = true;
    else if (flag && input[i] == x) cnt ++;
  }
  answer = min(answer, cnt);
  cnt = 0;
  flag = false;
  for(int i=input.size()-1;i>=0;i--) {
    if (input[i] != x) flag = true;
    else if (flag && input[i] == x) cnt ++;
  }
  answer = min(answer, cnt);
}

int main(int argc, const char * argv[]) {
  int n;
  cin >> n;
  cin >> input;
  unordered_set<char> set;
  for(auto ch: input) {
    set.insert(ch);
  }
  if (set.size() == 1) {
    cout << 0;
  } else {
    group('R');
    group('B');
    cout << answer;
  }
  return 0;
}
