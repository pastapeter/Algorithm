//
//  main.swift
//  ps1888
//
//  Created by Jung peter on 2/15/23.
//

import Foundation

struct Coor: Hashable {
  var x: Int
  var y: Int
}

let mn = readLine()!.split(separator: " ").map { Int(String($0))!}
let m = mn[0]
let n = mn[1]
var board = [[Int]]()
for _ in 0..<m {
  let temp = readLine()!.map { Int(String($0))!}
  board.append(temp)
}
var visited: Set<Coor> = []

func spread(x: Int, y: Int, k: Int) {
  var len = 2*k+1
  
  let dx = [-1, 1, 0, 0]
  let dy = [0, 0, 1, -1]
  let xlimit = [x - k, x + k]
  let ylimit = [y - k, y + k]
  
  var queue = [Coor(x: x, y: y)]
  visited.insert(Coor(x: x, y: y))
  
  while !queue.isEmpty {
    
    var now = queue.removeFirst()
    
    for i in 0..<4 {
      
      var nx = now.x + dx[i]
      var ny = now.y + dy[i]
      
      if nx < xlimit[0] || nx > xlimit[1] || ny < ylimit[0] || ny > ylimit[1] {
         continue
      }
      
      if nx < 0 || nx >= n || ny < 0 || ny >= m {
        continue
      }
      
      if board[ny][nx] < k {
        queue.append(Coor(x: nx, y: ny))
        visited.insert(Coor(x: nx, y: ny))
        board[ny][nx] = k
      }
      
      
    }
    
  }
  
}

func bfs(start: Coor) -> Int {
  var queue = [start]
  visited.insert(start)
  var cnt = 0
  let dx = [1, -1, 0, 0]
  let dy = [0, 0, 1, -1]
  
  while !queue.isEmpty {
    
    var now = queue.removeFirst()
    cnt += 1
    
    for i in 0..<4 {
      
      let nx = now.x + dx[i]
      let ny = now.y + dy[i]
      
      if nx < 0 || ny < 0 || nx >= n || ny >= m {
        continue
      }
      
      if !visited.contains(Coor(x: nx, y: ny)) && board[ny][nx] != 0 {
        queue.append(Coor(x: nx, y: ny))
        visited.insert(Coor(x: nx, y: ny))
      }
    }
  }
  return cnt
}
 

var cnt = 0
while true {
  
  visited.removeAll()
  var mstcnt = 0
  for y in 0..<m {
    for x in 0..<n {
      if board[y][x] != 0 && !visited.contains(Coor(x: x, y: y)) {
        if bfs(start: Coor(x: x, y: y)) > 0 {
          mstcnt += 1
        }
      }
    }
  }
  
  if mstcnt == 1 {
     break
  }
  
  visited.removeAll()
  cnt += 1
  for y in 0..<m {
    for x in 0..<n {
      if board[y][x] != 0 && !visited.contains(Coor(x: x, y: y)) {
        spread(x: x, y: y, k: board[y][x])
      }
    }
  }
  
  for y in 0..<m {
    print(board[y])
  }
  print("")
 
  
}


print(cnt)
