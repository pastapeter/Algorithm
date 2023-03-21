//
//  main.swift
//  ps1941
//
//  Created by Jung peter on 3/21/23.
//

/* 이름이 이름인 만큼, 7명의 여학생들로 구성되어야 한다.
 강한 결속력을 위해, 7명의 자리는 서로 가로나 세로로 반드시 인접해 있어야 한다.
 화합과 번영을 위해, 반드시 ‘이다솜파’의 학생들로만 구성될 필요는 없다.
 그러나 생존을 위해, ‘이다솜파’가 반드시 우위를 점해야 한다. 따라서 7명의 학생 중 ‘이다솜파’의 학생이 적어도 4명 이상은 반드시 포함되어 있어야 한다.
 N => 5 && 시간이 2초 -> 2억의 연산
 충분히 완탐(백트래킹)가능함
 4^7
 */

import Foundation

struct Coor: Hashable {
  var x: Int
  var y: Int
}

func combi<T>(_ nums: [T], _ targetNum: Int) -> [[T]] {
  var result = [[T]]()
  
  func combination(_ index: Int, _ nowCombi: [T]) {
    if nowCombi.count == targetNum {
      result.append(nowCombi)
      return
    }
    
    for i in index..<nums.count {
      combination(i+1, nowCombi + [nums[i]])
    }
  }
  
  combination(0, [])
  return result
}

var board: [[String]] = []
var coors: [Coor] = []
var ans = 0
let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]
for _ in 0..<5 {
  let temp = readLine()!.map { String($0) }
  board.append(temp)
}

for y in 0..<5 {
  for x in 0..<5 {
    coors.append(Coor(x: x, y: y))
  }
}

func inRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < 5 && y >= 0 && y < 5
}

func bfs(start: Set<Coor>) -> Bool {
  var start = start
  var first = start.removeFirst()
  var visited: Set<Coor> = [first]
  var queue = [first]
  
  while !queue.isEmpty {
    let poped = queue.removeFirst()
    var x = poped.x
    var y = poped.y
    
    for i in 0..<4 {
      let nx = x + dx[i]
      let ny = y + dy[i]
      let newCoor = Coor(x: nx, y: ny)
      if !inRange(nx, ny) { continue }
      if !visited.contains(newCoor) && start.contains(newCoor) {
        queue.append(Coor(x: nx, y: ny))
        visited.insert(Coor(x: nx, y: ny))
        start.remove(newCoor)
      }
    }
  }
  return start.count == 0
}

var coorCombi = combi(coors, 7)
var candidates: [[Coor]] = []
for coors in coorCombi {
  var cnt = 0
  for coor in coors {
    if board[coor.y][coor.x] == "S" {
        cnt += 1
    }
  }
  if cnt >= 4 {
    candidates.append(coors)
  }
}

for candidate in candidates {
  if bfs(start: Set(candidate)) {
    ans += 1
  }
}
print(ans)
//func backtracking(start: Coor) {
//  if visited.count == 0 {
//    visited.insert(start)
//  }
//  if visited.count == 7 {
//    var cnt = 0
//    for coor in visited {
//      if board[coor.y][coor.x] == "S" {
//        cnt += 1
//      }
//    }
//    if cnt >= 4 {
//      ans += 1
//      print(visited)
//    }
//  }
//
//  var candidates: [Coor] = []
//  for i in 0..<4 {
//    let nx = start.x + dx[i]
//    let ny = start.y + dy[i]
//    if !inRange(nx, ny) { continue }
//    if !visited.contains(Coor(x: nx, y: ny)) {
//      candidates.append(Coor(x: nx, y: ny))
//    }
//  }
//}
//
//for y in 0..<5 {
//  for x in 0..<5 {
//    visited.removeAll()
//    backtracking(start: Coor(x: x, y: y))
//  }
//}
//print(ans)

