
//
//  main.cpp
//  softeer1
//
//  Created by Jung peter on 5/30/23.
//

#include <iostream>
#include <vector>
#include <algorithm>
#include <deque>
#include <queue>
#include <map>

using namespace std;


// 계약 모델 빈도수 높은수부터 반환
// 알파벳 하나로 enque
// deque -> 빈도수가 가장 높은 문자, 가장 먼저 endque된 문자 반환하고 삭제
// 빈도수가 같다면 가장 먼저 enqueue된 문자 반환 제거
// 비어있으면 *
deque<int> fq;
map<char, int> dic;
vector<char> answers;
int n;

bool cmp(pair<char, int> lhs, pair<char, int> rhs) {
  return lhs.second > rhs.second;
}

int main(int argc, const char * argv[]) {
  cin >> n;
  while(n--) {
    string command;
    char model;
    cin >> command;
    if (command == "enqueue") {
      cin >> model;
      fq.push_back(model);
      if (dic.find(model) == dic.end()) {
        dic.insert({model, 1});
      } else {
        dic[model]++;
      }
    } else {
      if (fq.size() != 0) {
        vector<pair<char, int>> temp(dic.begin(), dic.end());
        sort(temp.begin(), temp.end(), cmp);
        vector<char> maxEles;
        maxEles.push_back(temp[0].first);
        for(int i=0;i<temp.size();i++) {
          if (temp[i].second == temp[0].second && i != 0) {
            maxEles.push_back(temp[i].first);
          }
        }
        
        if (maxEles.size() == fq.size()) {
          answers.push_back(fq.front());
          dic[fq.front()]--;
          fq.pop_front();
        } else {
          for(int i=0;i<fq.size();i++) {
            if(find(maxEles.begin(), maxEles.end(), fq[i]) != maxEles.end()) {
              answers.push_back(fq[i]);
              dic[fq[i]]--;
              fq.erase(fq.begin()+i);
              break;
            }
          }
        }
      } else {
        answers.push_back('*');
      }
    }
  }
  for(auto answer: answers) {
    cout << answer << " ";
    
  }
  return 0;
}
