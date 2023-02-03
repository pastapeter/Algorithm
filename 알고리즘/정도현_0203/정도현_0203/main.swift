//
//  main.swift
//  정도현_0203
//
//  Created by Jung peter on 2/3/23.
//

import Foundation

struct Coor: Hashable {
  var x: Int
  var y: Int
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = NM[0]  // y
let m = NM[1] // x
var board = [[Int]]()

for y in 0..<n {
  board.append(readLine()!.split(separator: " ").map { Int(String($0))!})
}

func solution() {
  var cnt = 0
  for y in 0..<n {
    for x in 0..<m {
      if board[y][x] == 0 {
        cnt = bfs(start: Coor(x: x, y: y), cnt: cnt+1)
      }
    }
  }
  print(cnt)
}

func bfs(start: Coor, cnt: Int) -> Int {
  
  let dx = [-1, 1, 0, 0]
  let dy = [0, 0, 1, -1]
  var queue: [Coor] = [start]
  
  while !queue.isEmpty {
    
    var now = queue.removeFirst()
    
    for i in 0..<4 {
      var nx = now.x + dx[i]
      var ny = now.y + dy[i]
      
      if nx < 0 {
        nx += m
      }
      if ny < 0 {
        ny += n
      }
      if nx >= m {
        nx -= m
      }
      if ny >= n {
        ny -= n
      }
      
      if board[ny][nx] == 0 {
        queue.append(Coor(x: nx, y: ny))
        board[ny][nx] = cnt
      }
      
    }
    
  }
  return cnt
}

solution()
