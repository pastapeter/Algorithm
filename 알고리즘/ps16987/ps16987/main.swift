//
//  main.swift
//  ps16987
//
//  Created by Jung peter on 3/10/23.
//

/*
 가장 왼쪽의 계란을 든다.
 손에 들고 있는 계란으로 깨지지 않은 다른 계란 중에서 하나를 친다. 단, 손에 든 계란이 깨졌거나 깨지지 않은 다른 계란이 없으면 치지 않고 넘어간다. 이후 손에 든 계란을 원래 자리에 내려놓고 3번 과정을 진행한다.
 가장 최근에 든 계란의 한 칸 오른쪽 계란을 손에 들고 2번 과정을 다시 진행한다. 단, 가장 최근에 든 계란이 가장 오른쪽에 위치한 계란일 경우 계란을 치는 과정을 종료한다.
 */

/*
 문제 풀이 - 백트래킹
 처음부터 생각난건 백트래킹이다.
 코딩하면서 처음에 놓친부분은
 치기전에 달걀이 이미 깨져있는것 -> 이것에 대해서 if문을 달았지만, else 문에 다른 것에 대한 가지치기 조건을 했어야하는데, else를 쓰지않고 하다보니 조금 오래걸림
 깨진 계란이 없을 경우도 역시 그냥 넘겨야하는 상황 -> 이때도 flag로 돌릴경우, 돌리지 않을경우 이거 생각하고 해야하는데
 그냥 돌려버림 -> 물론 답이 나오긴함 어차피 max를 하고 다해버리니깐 -> 근데 시간초과임
 
또 다른 경우, cnt를 tracking하면 더 빠를것같음, 먼저 그렇게 했는데 잘안되서 방향을 바꾸긴함
 */

import Foundation

struct Egg {
  var s: Int
  var w: Int
}

let n = Int(readLine()!)!
var eggs = [Egg]()
for _ in 0..<n {
  let tmp = readLine()!.split(separator: " ").map { Int(String($0))!}
  eggs.append(Egg(s: tmp[0], w: tmp[1]))
}

func crash(left: Int, right: Int, eggs: [Egg]) -> [Egg] {
  var eggs = eggs
  eggs[left].s = eggs[left].s - eggs[right].w
  eggs[right].s = eggs[right].s - eggs[left].w
  return eggs
}

func newCrash(left:Int, right: Int) {
  eggs[left].s = eggs[left].s - eggs[right].w
  eggs[right].s = eggs[right].s - eggs[left].w
}

func restore(left: Int, right: Int) {
  eggs[left].s = eggs[left].s + eggs[right].w
  eggs[right].s = eggs[right].s + eggs[left].w
}

var ans = 0

// 이거 왜 안되지???
func secondBacktracking(index: Int, cnt: Int) {
  if index == eggs.count {
    ans = max(ans, cnt)
    return
  }
  
  if eggs[index].s <= 0 {
    secondBacktracking(index: index+1, cnt: cnt)
  } else {
    var flag = false
    for i in 0..<n {
      if eggs[i].s <= 0 { continue }
      if i == index { continue }
      flag = true
      newCrash(left: index, right: i)
      if eggs[i].s <= 0 && eggs[index].s > 0 {
        secondBacktracking(index: index+1, cnt: cnt+1)
        restore(left: index, right: i)
      } else if eggs[index].s <= 0 && eggs[i].s > 0  {
        secondBacktracking(index: index+1, cnt: cnt+1)
        restore(left: index, right: i)
      } else if eggs[i].s <= 0 && eggs[index].s <= 0 {
        secondBacktracking(index: index+1, cnt: cnt+2)
        restore(left: index, right: i)
      } else {
        secondBacktracking(index: index+1, cnt: cnt)
        restore(left: index, right: i)
      }
    }
    if flag == false {
      secondBacktracking(index: index+1, cnt: cnt)
    }
  }
}

func backtracking(index: Int, eggs: [Egg]) {
  
  if index == eggs.count {
    let cnt = eggs.filter { $0.s <= 0}.count
    ans = max(ans, cnt)
    return
  }
  
  //치기 전에 손에 든 달걀이 깨져있으면 다음꺼
  if eggs[index].s <= 0 {
    backtracking(index: index+1, eggs: eggs)
  } else {
    var flag = false
    for i in 0..<n {
      if i == index { continue }
      if eggs[i].s <= 0 { continue }
      // 친다
      let temp = crash(left: index, right: i, eggs: eggs)
      flag = true
      backtracking(index: index+1, eggs: temp)
    }
    // 깨진 계란이 없으면 여기까지 옴
    if flag == false {
      backtracking(index: index+1, eggs: eggs)
    }
  }
}

//backtracking(index: 0, eggs: eggs)
secondBacktracking(index: 0, cnt: 0)
print(ans)

