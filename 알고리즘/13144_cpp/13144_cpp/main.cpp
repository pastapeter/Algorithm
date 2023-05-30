//
//  main.cpp
//  13144_cpp
//
//  Created by Jung peter on 5/25/23.
//

#include <iostream>
#include <vector>
#include <unordered_set>
using namespace std;
int n;
vector<int> list;
bool visited[100001];
unsigned long long answer = 0;

int main(int argc, const char * argv[]) {
  cin >> n;
  for(int i=0;i<n;i++) {
    int temp;
    cin >> temp;
    list.push_back(temp);
  }
  int start = 0;
  int end = 0;
  while (start < n) {
    while(end < n) {
      if(visited[list[end]]) break;
      visited[list[end]] = true;
      end++;
    }
    answer += end-start;
    visited[list[start]] = false;
    start++;
  }
  cout << answer;
  return 0;
}
