//
//  main.cpp
//  9012_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <vector>
#include <deque>
using namespace std;
int T;

int main(int argc, const char * argv[]) {
  cin >> T;
  while(T--) {
    vector<char> stack;
    string temp;
    cin >> temp;
    bool flag = false;
    for(int i=0;i<temp.size();i++){
      if (stack.size() == 0) {
        if (temp[i]==')') {
          cout << "NO" << endl;
          flag = true;
          break;
        } else {
          stack.push_back(temp[i]);
        }
      }
      else {
        if(temp[i] == '(') {
          stack.push_back(temp[i]);
        }
        else {
          char top = stack.back();
          if (top == '(') {
            stack.pop_back();
          } else {
            cout << "NO" << endl;
            flag = true;
            break;
          }
        }
      }
    }
    if (!flag) {
      if (stack.size() == 0) {
        cout << "YES\n";
      } else {
        cout << "NO\n";
      }
    }
  }
  return 0;
}
