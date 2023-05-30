//
//  main.cpp
//  1522
//
//  Created by Jung peter on 5/24/23.
//

#include <iostream>
#include <string>
using namespace std;

int answer = 1001;

int main(int argc, const char * argv[]) {
  string input;
  cin >> input;
  int size = 0;
  for(auto i: input) {
    if (i == 'a') {
      size++;
    }
  }
  string newinput = input + input;
  for(int i=0;i<input.size();i++) {
    int cnt = 0;
    for(auto ele: newinput.substr(i, size)) {
      if (ele == 'b') {
        cnt++;
      }
    }
    answer = min(cnt, answer);
  }
  cout << answer;
  return 0;
}
