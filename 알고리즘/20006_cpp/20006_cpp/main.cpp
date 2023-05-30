//
//  main.cpp
//  20006_cpp
//
//  Created by Jung peter on 5/26/23.
//
//방이 없으면 새로운 방생성
//처음 입장 플레이어 기준 -10 ~ +10
//입장 - 모두찰떄까지(먼저 생성)

#include <iostream>
#include <vector>
#include <algorithm>
#include <deque>
using namespace std;

struct Room {
  vector<pair<string, int>> players;
};

int p,l, m;
string n;
deque<pair<string, int>> waitingList;
vector<Room> rooms;

bool cmp(pair<string, int> lhs, pair<string, int> rhs) {
  return lhs.first < rhs.first;
}

int main(int argc, const char * argv[]) {
  // m은 정원임
  cin >> p >> m;
  for(int i=0;i<p;i++) {
    cin >> l >> n;
    waitingList.push_back({n,l});
  }
  
  while(waitingList.size() != 0) {
    
    pair<string, int> player = waitingList.front(); waitingList.pop_front();
    
    bool flag = false;
    for(int i=0;i<rooms.size();i++) {
      if (abs(player.second - rooms[i].players[0].second) <= 10 && rooms[i].players.size() < m && rooms[i].players.size() > 0) {
        rooms[i].players.push_back(player);
        flag = true;
        break;
      }
    }

    // 들어갈 자리가 없음
    if (!flag) {
      Room room;
      room.players.push_back(player);
      rooms.push_back(room);
    }
    
  }
  
  for(auto room: rooms) {
    sort(room.players.begin(), room.players.end(), cmp);
    if (room.players.size() == m) {
      cout << "Started!\n";
    } else {
      cout << "Waiting!\n";
    }
    for(auto player: room.players) {
      cout << player.second << " " << player
        .first << endl;
    }
  }
  
  return 0;
}
