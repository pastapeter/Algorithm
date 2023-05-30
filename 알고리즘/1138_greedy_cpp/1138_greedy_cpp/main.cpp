//
//  main.cpp
//  1138_greedy_cpp
//
//  Created by Jung peter on 5/28/23.
//

#include <iostream>
using namespace std;

int p[5];

int main(int argc, const char * argv[]) {
  int N, left;
  cin >> N;
  for(int i=0;i<N;i++) {
    cin >> left;
    for(int j=0;j<N;j++) {
      if(left == 0 && p[j] == 0) { //내 옆에 키큰 사람이 없는데, 자신의 자리
        p[j] = i+1;
        break;
      } else if (p[j] == 0) {
        left--;
      }
    }
  }
  for(int i=0;i<N;i++) {
    cout << p[i] << ' ';
  }
  return 0;
}
