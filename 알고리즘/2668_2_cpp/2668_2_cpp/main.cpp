//
//  main.cpp
//  2668_2_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;
int n;
int map[2][101];
bool visited[101];
int firstStart;
vector<int> answers;

void dfs(int start) {
  visited[start] = true;
  int next = map[1][start];
  if (!visited[next]) {
    dfs(next);
  } else {
    if (next == firstStart) {
      answers.push_back(next);
    }
  }
}

int main(int argc, const char * argv[]) {
  cin >> n;
  for(int i=1;i<=n;i++) {
    map[0][i] = i;
    cin >> map[1][i];
  }
  for(int i=1;i<=n;i++) {
    for(int i=0;i<101;i++) {
      visited[i] = false;
    }
    firstStart = i;
    dfs(i);
  }
  sort(answers.begin(), answers.end());
  cout << answers.size() << endl;
  for(auto answer: answers) {
    cout << answer << endl;
  }
  return 0;
}
