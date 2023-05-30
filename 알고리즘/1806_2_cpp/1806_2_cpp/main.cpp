//
//  main.cpp
//  1806_2_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <vector>
using namespace std;
int n;
long long s;
vector<int> list;

int main(int argc, const char * argv[]) {
  cin >> n >> s;
  for(int i=0;i<n;i++) {
    int temp;
    cin >> temp;
    list.push_back(temp);
  }
  int start = 0;
  int end = -1;
  int sum = 0;
  int answer = n+1;
  while(end < n) {
    end++;
    sum += list[end];
    while (sum >= s && start <= end) {
      answer = min(answer, end-start+1);
      sum -= list[start];
      start++;
    }
  }
  if (answer == n+1) {
    cout << 0;
  } else {
    cout << answer;
  }
  return 0;
}
