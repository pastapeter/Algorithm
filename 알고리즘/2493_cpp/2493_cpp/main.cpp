//
//  main.cpp
//  2493_cpp
//
//  Created by Jung peter on 5/25/23.
//

#include <iostream>
#include <vector>
#include <deque>
using namespace std;

int n;
vector<int> towers;
vector<int> answer;
deque<pair<int, int>> stack;

int main(int argc, const char * argv[]) {
  cin >> n;
  for(int i=0;i<n;i++) {
    int temp;
    cin >> temp;
    towers.push_back(temp);
  }
  for(int i=0;i<n;i++) {
    if (stack.size() == 0) {
      stack.push_back({towers[i], i+1});
      answer.push_back(0);
    }
    else {
      while (true) {
        if (stack.back().first < towers[i]) {
          stack.pop_back();
        } else if(stack.back().first > towers[i]) {
          answer.push_back(stack.back().second);
          stack.push_back({towers[i], i+1});
          break;
        }
        if (stack.size() == 0) {
          stack.push_back({towers[i], i+1});
          answer.push_back(0);
          break;
        }
      }
    }
  }
  for(auto i: answer) {
    cout << i << " ";
  }
  return 0;
}
