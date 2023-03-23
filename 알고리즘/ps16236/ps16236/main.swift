//
//  main.swift
//  ps16236
//
//  Created by Jung peter on 3/23/23.
//

import Foundation

struct Coor: Hashable {
  var x: Int
  var y: Int
}

struct Shark {
  var coor: Coor
  var size: Int
}

let n = Int(readLine()!)!
let dx = [-1,1,0,0]
let dy = [0,0,-1,1]
var board: [[Int]] = []
var shark = Shark(coor: Coor(x: 0, y: 0), size: 0)
var numberOfEaten = 0
var ans = 0
var shortestRoute: [Coor] = []
for _ in 0..<n {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  board.append(temp)
}

//아기상어 처음 위치
for y in 0..<n {
  for x in 0..<n {
    if board[y][x] == 9 {
      shark = Shark(coor: Coor(x: x, y: y), size: 2)
      board[y][x] = 0
    }
  }
}

func inRange(_ x: Int, _ y : Int) -> Bool {
  return x >= 0 && x < n && y >= 0 && y < n
}

func bfs() -> Bool {
  var queue = [(shark.coor, 0)]
  var idx = 0
  var visited: Set<Coor> = [shark.coor]
  var dist = Int.max
  var victimList: [Coor] = []
  while queue.count > idx {
    let poped = queue[idx]
    idx += 1
    let cnt = poped.1
    let coor = poped.0
    
    // 최소 거리만 찾는다.
    if cnt > dist { continue }
    
    // 먹을 수 있는 물고기라면
    if board[coor.y][coor.x] > 0 && board[coor.y][coor.x] < shark.size {
      dist = cnt
      victimList.append(coor)
    }
    
    for i in 0..<4 {
      let nx = coor.x + dx[i]
      let ny = coor.y + dy[i]
      if !inRange(nx, ny) { continue }
      if !visited.contains(Coor(x: nx, y: ny)) && board[ny][nx] <= shark.size {
        visited.insert(Coor(x: nx, y: ny))
        queue.append((Coor(x: nx, y: ny), cnt+1))
      }
    }
  }
  
  // 그러면 victimlist에 일단 최소거리 물고기들이 있음
  if victimList.isEmpty { return false }
  
  //최소거리물고기들을 조건에 맞추어 sort 시킨다.
  victimList.sort(by: {
    if $0.y == $1.y {
      return $0.x < $1.x
    }
    return $0.y < $1.y
  })
  // 그중 가장 처음친구가 target임
  let target = victimList.first!
  // 아기상어가 하나 먹는다.
  numberOfEaten += 1
  // 아기상어가 먹었는데,크기가 같으면?
  if numberOfEaten == shark.size {
    shark.size += 1
    numberOfEaten = 0
  }
  
  //아기상어는 움직인다.
  //아기상어가 먹으면서 움직이는데, target만 지우는 이유는 target이 가는길에 가장 가까이 있는 친구이기 때문이다.
  board[target.y][target.x] = 0
  shark.coor = target
  ans += dist
  return true
}

while true {
  if !bfs() {
    print(ans)
    break
  }
  for y in 0..<n {
    print(board[y])
  }
  print("")
}
