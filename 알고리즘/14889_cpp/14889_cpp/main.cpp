//
//  main.cpp
//  14889_cpp
//
//  Created by Jung peter on 5/30/23.
//

#include <iostream>
#include <vector>
#include <unordered_set>
#include <cmath>
#include <climits>
using namespace std;
// S[i][j] 는 i번 사람과 j번 사람이 같은 팀에 속했을때 팀에 더해지는 능력치
int n;
int map[21][21];
int answer = INT_MAX;
vector<int> persons;
vector<vector<int>> v;
void combination(vector<int> arr, int depth, int limit) {
  if (depth == n) {
    if (arr.size() == limit) {
      v.push_back(arr);
    }
    return;
  }
  
  arr.push_back(persons[depth]);
  combination(arr, depth+1, limit);
  arr.pop_back();
  combination(arr, depth+1, limit);
}

int main(int argc, const char * argv[]) {
  cin >> n;
  for(int y=0;y<n;y++) {
    for(int x=0;x<n;x++) {
      cin >> map[y][x];
    }
  }
  
  for(int i=0;i<n;i++) {
    persons.push_back(i);
  }
  
  combination(vector<int>(), 0, n/2);
  
  for(auto numbers:v) {
    int answer1 = 0;
    int answer2 = 0;
    for(auto i:numbers) {
      for(auto j:numbers) {
        answer1 += map[i][j];
      }
    }
    
    unordered_set<int> tempPerson(persons.begin(), persons.end());
    for(auto i:numbers) {
      tempPerson.erase(i);
    }
    for(auto i:tempPerson) {
      for(auto j:tempPerson) {
        answer2 += map[i][j];
      }
    }
    
    answer = min(answer, abs(answer1-answer2));
  }
  cout << answer;
  return 0;
}
