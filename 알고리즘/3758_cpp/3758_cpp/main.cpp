//
//  main.cpp
//  3758_cpp
//
//  Created by Jung peter on 5/25/23.
//

//최종점수가 같은 경우, 풀이를 제출한 횟수가 적은 팀 순위가 높음
//최종 점수도 같고 제출회수가같은경우, 시간으로 따짐
//각 줄에 ID, 문제번호, 점수

#include <iostream>
#include <map>
#include <vector>
#include <algorithm>
using namespace std;
struct info {
  int score[101] = { 0 };
  int time;
  int tryTime;
};

int T, n, k, t, m;
map<int, info> db;

bool cmp(pair<int, info> a, pair<int, info> b) {
  int ascore = 0;
  int bscore = 0;
  for(auto i: a.second.score) {
    ascore += i;
  }
  for(auto i: b.second.score) {
    bscore += i;
  }
  if (ascore == bscore) {
    if (a.second.tryTime == b.second.tryTime) {
      return a.second.time < b.second.time;
    }
    return a.second.tryTime < b.second.tryTime;
  } else if (ascore > bscore) {
    return true;
  }
  return false;
}

int main(int argc, const char * argv[]) {
  cin >> T;
  for(int i=0;i<T;i++) {
    db = { };
    cin >> n >> k >> t >> m;
    for(int time=0;time<m;time++) {
      int id, no, score;
      cin >> id >> no >> score;
      if (db.find(id) == db.end()) {
        info temp;
        temp.score[no] = score;
        temp.tryTime = 1;
        temp.time = time;
        db.insert({ id,  temp});
      } else {
        db[id].score[no] = max(score, db[id].score[no]);
        db[id].time = time;
        db[id].tryTime++;
      }
    }
    vector<pair<int, info>> temp(db.begin(), db.end());
    sort(temp.begin(), temp.end(), cmp);
    int ans = 0;
    for(int i=0;i<temp.size();i++) {
      if (temp[i].first == t) {
        ans = i+1;
      }
    }
    cout << ans << endl;
  }
  return 0;
}
