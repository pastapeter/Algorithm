//
//  main.swift
//  ps14466
//
//  Created by Jung peter on 2/25/23.
//

import Foundation

struct Road: Hashable {
  var fromX: Int
  var fromY: Int
  var toX: Int
  var toY:Int
}

let nkr = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nkr[0]
let k = nkr[1]
let r = nkr[2]
var boards = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)

var roads = Set<Road>()
for _ in 0..<r {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  let road1 = Road(fromX: temp[0]-1, fromY: temp[1]-1, toX: temp[2]-1, toY: temp[3]-1)
  let road2 = Road(fromX: temp[2]-1, fromY: temp[3]-1, toX: temp[0]-1, toY: temp[1]-1)
  roads.insert(road1)
  roads.insert(road2)
}

for _ in 0..<k {
  let cow = readLine()!.split(separator: " ").map { Int(String($0))!}
  boards[cow[1]-1][cow[0]-1] = 1
}

struct Coor: Hashable {
  var x: Int
  var y: Int
}

func roadConnected(from: Coor, to: Coor) -> Bool {
  let road = Road(fromX: from.x, fromY: from.y, toX: to.x, toY: to.y)
  return roads.contains(road)
}

func bfs(start: Coor) -> Int {
  var queue = [start]
  var visited: Set<Coor> = [start]
  var cnt = 0
  let dx = [1, -1, 0, 0]
  let dy = [0, 0, 1, -1]
  boards[start.y][start.x] = 0
  
  while !queue.isEmpty {
    
    var now = queue.removeFirst()
    
    for i in 0..<4 {
      
      let nx = now.x + dx[i]
      let ny = now.y + dy[i]
      
      if nx < 0 || ny < 0 || nx >= n || ny >= n {
        continue
      }
      
      if !visited.contains(Coor(x: nx, y: ny)) && !roadConnected(from: now, to: Coor(x: nx, y: ny)) {
        if boards[ny][nx] == 1 { cnt += 1 }
        queue.append(Coor(x: nx, y: ny))
        visited.insert(Coor(x: nx, y: ny))
      }
    }
  }
  return cnt
}

func solve() -> Int {
  var couple = k*(k-1)/2
  for y in 0..<n {
    for x in 0..<n {
      if boards[y][x] == 1 {
        let temp = bfs(start: Coor(x: x, y: y))
        couple -= temp
      }
    }
  }
  return couple
}
print(solve())

