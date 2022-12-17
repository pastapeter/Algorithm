//
//  main.swift
//  mazesearch
//
//  Created by Jung peter on 12/3/22.
//

import Foundation


let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]
var maze = [[Int]]()

for y in 1...n {
  maze.append(readLine()!.map{Int(String($0))!})
}

struct Coor: Hashable {
  var x: Int
  var y: Int
}

func bfs(start: Coor) {
  var queue = [start]
  //  var visited: Set<Coor> = [start]
  var cnt = 0
  let dx = [1, -1, 0, 0]
  let dy = [0, 0, 1, -1]
  
  while !queue.isEmpty {
    
    var now = queue.removeFirst()
    
    for i in 0..<4 {
      
      let nx = now.x + dx[i]
      let ny = now.y + dy[i]
      
      if nx < 0 || ny < 0 || nx >= m || ny >= n {
        continue
      }
      
      if maze[ny][nx] == 1 {
        queue.append(Coor(x: nx, y: ny))
        maze[ny][nx] = maze[now.y][now.x] + 1
      }
    }
  }
}

bfs(start: Coor(x: 0, y: 0))
print(maze[n-1][m-1])
