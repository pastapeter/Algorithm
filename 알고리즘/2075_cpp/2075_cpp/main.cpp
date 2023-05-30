//
//  main.cpp
//  2075_cpp
//
//  Created by Jung peter on 5/26/23.
//

/*
 우선순위 큐에 전체를 안넣어도 되는 이유?
 N번째 큰수를 출력하는 것인데 왜?
 1개를 넣는다. N이 5라고 했을때,
 우선순위에 6개 들어갔을때부터 최소힙인것은 greater을 쓰면되고
 최대힙을 쓰고 싶다면 less를 사용할 수 있다.
 그러면 해결
 */

#include <iostream>
#include <vector>
#include <queue>
using namespace std;
int n;

int main(int argc, const char * argv[]) {
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);
  cin >> n;
  priority_queue<int, vector<int>, greater<int>> pq;
  int temp;
  for(int i=0;i<n*n;i++) {
    cin >> temp;
    pq.push(temp);
    if(pq.size() > n) {
      pq.pop();
    }
  }
  cout << pq.top();
  return 0;
  
}
