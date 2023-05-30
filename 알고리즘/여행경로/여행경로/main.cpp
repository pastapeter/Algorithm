//
//  main.cpp
//  여행경로
//
//  Created by Jung peter on 5/29/23.
//

#include <string>
#include <vector>
#include <iostream>
#include <unordered_map>
#include <algorithm>

/*
 중요한점 -> 티켓자체를 순회하는것인듯
 */

using namespace std;
unordered_map<string, vector<string>> graph;
vector<string> answer;
vector<vector<string>> ticket;
bool visited[10001];
int cnt;

bool dfs(string start, int depth) {
  answer.push_back(start);
  if (depth == cnt) {
      return true;
  }
  for(int i=0;i<ticket.size();i++) {
    if (visited[i]) continue;;
    if (ticket[i][0] == start) {
      visited[i] = true; //해당 티켓은 써버림
      if (dfs(ticket[i][1], depth+1)) {
        return true;
      }
      answer.pop_back();
      visited[i] = false;
    }
  }
  return false;
}

vector<string> solution(vector<vector<string>> tickets) {
    cnt = tickets.size();
    for(auto ticket: tickets) {
        string from = ticket[0];
        string to = ticket[1];
        if (graph.find(from) == graph.end()) {
            graph.insert({from, {to}});
        } else {
            graph[from].push_back(to);
        }
    }
    ticket = tickets;
  sort(ticket.begin(), ticket.end());
    dfs("ICN", 0);
    return answer;
}

int main(int argc, const char * argv[]) {
  // insert code here...
  std::cout << "Hello, World!\n";
  return 0;
}
