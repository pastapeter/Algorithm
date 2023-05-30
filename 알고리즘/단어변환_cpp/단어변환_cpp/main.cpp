//
//  main.cpp
//  단어변환_cpp
//
//  Created by Jung peter on 5/29/23.
//

#include <string>
#include <vector>
#include <iostream>

using namespace std;
int answer = 100000001;

void dfs(string start, string target, vector<string> words, int ans) {
    if (start == target) {
        answer = min(answer, ans);
        return;
    }
    for(int i=0;i<words.size();i++) {
        int cnt = 0;
        string word = words[i];
        for(int j=0;j<start.size();j++) {
            if (start[j] == word[j]) cnt++;
        }
      /*
       헤맸던 이유, index를 기반으로 뺏따 꼈다하는데, 중간 노드 지우고, 맨마지막에 넣으니깐
        누락되는 사건이 일어났다.
       index를 기반으로 뺐다꼈다하는것은 새로만들어서 넣어줘라
       */
        if (cnt == start.size()-1) {
            vector<string> newWords = words;
            newWords.erase(newWords.begin()+i);
            dfs(word, target, newWords, ans+1);
        }
    }
    
}

int solution(string begin, string target, vector<string> words) {
    dfs(begin, target, words, 0);
    if (answer == 100000001) {
        return 0;
    } else {
        return answer;
    }
    return answer;
}

int main(int argc, const char * argv[]) {
  
  return 0;
}
