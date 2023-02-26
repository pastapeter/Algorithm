#include <string>
#include <vector>
#include <iostream>
#include <algorithm>

using namespace std;

int dfs(string begin, string target, vector<string> words, int turn) {
    
    if (words.size() == 0 && begin == target)  return turn;
    else if (words.size() == 0) return 0;
    words.erase(remove(words.begin(), words.end(), begin), words.end());
    for(int i=0;i<words.size();i++) {
        int cnt = 0;
        for(int j=0;i<words[i].size();j++) {
            if (begin[j] == words[i][j]) {
                cnt ++;
            }
        }
        if (cnt == begin.size() - 1) {
            turn = dfs(words[i], target, words, turn+1);
            cout << "중간단계" << turn << endl;
        }
    }
    return turn;
}

int solution(string begin, string target, vector<string> words) {
    
    if (find(words.begin(), words.end(), target) == words.end()) {
        return 0;
    }
    int answer = 0;
    int temp = dfs(begin, target, words, 0);
    answer = max(answer, temp);
    return answer;
}

int main() {
    vector<string> words{"hot", "dot", "dog", "lot", "log", "cog"}; 
    cout << solution("hit", "cog", words);

    return 0;
}

