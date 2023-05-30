//
//  main.cpp
//  20920_cpp
//
//  Created by Jung peter on 5/28/23.
//

#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>
using namespace std;

// 자주 나오는 단어일 수록 앞에 배치
// 해당 단어의 길이가 길수록 앞에
// 사전순
// M 길이 이상

int n, m;
unordered_map<string, int> words;
vector<string> wordsV;
string temp;

bool cmp(string lhs, string rhs) {
  if (lhs.size() == rhs.size() && words[lhs] == words[rhs]) {
    return lhs < rhs;
  } else if (words[lhs] == words[rhs]) {
    return lhs.size() > rhs.size();
  }
  return words[lhs] > words[rhs];
}

int main(int argc, const char * argv[]) {
  ios::sync_with_stdio(false); cin.tie(0);
  cin >> n >> m;
  for(int i=0;i<n;i++) {
    cin >> temp;
    if (temp.size() < m) continue;
    if(words.find(temp) == words.end()) {
      words.insert({temp, 1});
      wordsV.push_back(temp);
    } else {
      words[temp]++;
    }
  }
  sort(wordsV.begin(), wordsV.end(), cmp);
  for( auto word: wordsV) {
    cout << word << "\n";
  }
  return 0;
}
