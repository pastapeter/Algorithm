//
//  main.cpp
//  2668_cpp
//
//  Created by Jung peter on 5/28/23.
//

#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int n;
int map[2][101];
bool visited[101];
// 위에서 고른 i+1 집합
// 아래에 있는 map[1][i] 집합
// 이 둘이 같을 경우?
vector<vector<int>> graph;
vector<int> answers;
int firstStart = 0;

//처음에는 조합으로 완전탐색을 했다. -> 시간초과가 났다.
//두번째 풀이는 dfs를 쓰는방식이다. 느낌이 타고타고타고..! 이문제 생각보다 자주나온다.
//확실한건 시작점에서 타고 다시 들어왔을때, 다시 돌아오면 문제에서 찾는 것에 해당한다.
/*
 예를 들어서,
 1 3
 3 1
 이라고 했을떄, 1에서 시작하면, 1 -> 3 -> 3 -> 1이다.
 이때 1을 선택했을때, 1의 선택이 옳으려면 next의 선택이 1이면된다.
 그러면 3을 선택했을떄 역시 3으로 들어오게 된다. 그래서 오케이다.
1 2 3 4 5 6 7
3 1 1 5 5 4 6 의 경우
5시작에서 5를 넣고 바로 다음것이 5인 경우는 조건에 만족함
2시작하면 2 -> 1 -> 3 -> 1 이기 때문에 2로 다시 들어오지 않기에 불만족
1시작일 경우 1->3 -> 3 -> 1이기에 만족한다. 결국 순환을 찾는것이다.
 */

void dfs(int start) {
  visited[start] = true;
  for(auto next: graph[start]) {
    if (!visited[next]) dfs(next);
    else {
      if (next == firstStart) answers.push_back(next);
    }
  }
}


int main(int argc, const char * argv[]) {
  cin >> n;
  graph.resize(n+1, vector<int>());
  for(int i=0;i<n;i++) {
    map[0][i] = i+1;
    cin >> map[1][i];
    graph[i+1].push_back(map[1][i]);
  }
  for(int i=0;i<n;i++) {
    for(int j=0;j<101;j++) {
      visited[j] = false;
    }
    firstStart = map[0][i];
    dfs(map[0][i]);
  }
  cout << answers.size() << endl;
  sort(answers.begin(), answers.end());
  for(auto answer:answers) {
    cout << answer << "\n";
  }
  return 0;
}
