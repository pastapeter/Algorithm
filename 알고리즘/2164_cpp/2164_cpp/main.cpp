//
//  main.cpp
//  2164_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <vector>
#include <deque>
using namespace std;
int n;
deque<int> cards;

int main(int argc, const char * argv[]) {
  cin >> n;
  for(int i=n;i>=1;i--) {
    cards.push_back(i);
  }
  // [ 4, 3, 2]
  while (cards.size() > 1) {
    cards.pop_back();
    int temp = cards.back();
    cards.pop_back();
    cards.push_front(temp);
  }
  cout << cards[0] ;
  return 0;
}
