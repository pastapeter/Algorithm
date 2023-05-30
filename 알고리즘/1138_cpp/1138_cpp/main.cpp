//
//  main.cpp
//  1138_cpp
//
//  Created by Jung peter on 5/28/23.
//

#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;
int n;
vector<int> input;
vector<int> line;

bool func(vector<int> l) {
  bool flag = true;
  for(int i=0;i<l.size();i++) {
    if (i==0) {
      if (input[l[i]-1] != i) {
        flag = false;
        return false;
      }
    } else {
      int cnt = 0;
      for(int j=0;j<i;j++) {
        if (l[j] > l[i]) cnt++;
      }
      if(cnt != input[l[i]-1]) { flag = false;
        return false;
      }
    }
  }
  if (flag) {
    for(auto ele: l) cout << ele << " ";
    return true;
  }
  return false;
}

int main(int argc, const char * argv[]) {
  cin >> n;
  for(int i=0;i<n;i++) {
    int temp;
    cin >> temp;
    input.push_back(temp);
    line.push_back(i+1);
  }
  
  do {
    if (func(line)) return 0;
  } while(next_permutation(line.begin(), line.end()));

  
  return 0;
}
