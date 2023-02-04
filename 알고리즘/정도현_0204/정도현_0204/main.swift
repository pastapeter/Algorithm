//
//  main.swift
//  정도현_0204
//
//  Created by Jung peter on 2/4/23.
//

import Foundation

struct Coor: Hashable {
  var x: Int
  var y: Int
}

func synchronization() {
  for i in 0..<6 {
    board2[i].removeAll(where: { $0 == "." })
    var temp = [String](repeating: ".", count: 12 - board2[i].count)
    board2[i].insert(contentsOf: temp, at: 0)
  }
  for y in 0..<6 {
    for x in 0..<12 {
      board[x][y] = board2[y][x]
    }
  }
}

func bfs(start: Coor) {
  
  let dx = [-1, 1, 0, 0]
  let dy = [0, 0, 1, -1]
  var queue: [Coor] = [start]
  var count = 0
  
  while !queue.isEmpty {
    
    let now = queue.removeFirst()
    let color = board[now.y][now.x]
    
    for i in 0..<4 {
      
      let nx = now.x + dx[i]
      let ny = now.y + dy[i]
      
      if nx < 0 || ny < 0 || ny >= 12 || nx >= 6 {
        continue
      }
      
      if board[ny][nx] == "." { continue }
      
      if board[ny][nx] == color && !visited.contains(Coor(x: nx, y: ny)) {
        queue.append(Coor(x: nx, y: ny))
        visited.insert(Coor(x: nx, y: ny))
        count += 1
      }
    }
  }
  
  if count < 4 {
    visited.removeAll()
  } else {
    visited.forEach {
      board2[$0.x][$0.y] = "."
    }
    visited.removeAll()
  }
}

var board: [[String]] = []
var board2 = [[String]](repeating: [String](repeating: ".", count: 12), count: 6)
var visited: Set<Coor> = []

for _ in 0..<12 {
  let temp = readLine()!.map { String($0)}
  board.append(temp)
}

for y in 0..<12 {
  for x in 0..<6 {
    board2[x][y] = board[y][x]
  }
}

var answer = 0
var tempboard = board
while true {
  for y in 0..<12 {
    for x in 0..<6 {
      if board[y][x] != "." && !visited.contains(Coor(x: x, y: y)){
          bfs(start: Coor(x: x, y: y))
      }
    }
  }
  synchronization()
  if tempboard == board {
    break
  }
  tempboard = board
  answer += 1
}

for y in 0..<12 {
  for x in 0..<6 {
    if board[y][x] != "." && !visited.contains(Coor(x: x, y: y)){
        bfs(start: Coor(x: x, y: y))
    }
  }
}

print(answer)

