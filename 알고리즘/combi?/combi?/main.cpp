//
//  main.cpp
//  combi?
//
//  Created by Jung peter on 5/30/23.
//

#include <iostream>
#include <algorithm>
using namespace std;

int main(int argc, const char * argv[]) {
  int myInt[] = { 1,2,3};
  int a[] = { 0,0,1};
  do {
    cout << a[0] << a[1] << a[2] << " ";
  } while(next_permutation(a, a+3));
  return 0;
}
