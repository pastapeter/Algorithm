//
//  main.cpp
//  1927_cpp
//
//  Created by Jung peter on 5/25/23.
//

#include <iostream>
#include <queue>
using namespace std;

int n;

int main(int argc, const char * argv[]) {
  ios_base::sync_with_stdio(false); cout.tie(NULL); cin.tie(NULL);
  priority_queue<int, vector<int>, greater<int>> q;
  cin >> n;
  for(int i=0;i<n;i++) {
    int temp;
    cin >> temp;
    if (temp != 0) {
      q.push(temp);
    } else {
      if (q.empty()) {
        cout << "0\n";
      } else {
        cout << q.top() << "\n";
        q.pop();
      }
    }
    
  }
  return 0;
}
