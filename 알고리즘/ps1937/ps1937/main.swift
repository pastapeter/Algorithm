//
//  main.swift
//  ps1937
//
//  Created by Jung peter on 3/22/23.
//

import Foundation

let n = Int(readLine()!)!
var board: [[Int]] = []
let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]
var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)

for _ in 0..<n {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  board.append(temp)
}

func inRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < n && y >= 0 && y < n
}

func dfs(start: (x: Int, y: Int)) -> Int {
  
  if dp[start.y][start.x] > 0 {
    return dp[start.y][start.x]
  }
  dp[start.y][start.x] = 1
  for i in 0..<4 {
    
    let nx = start.x + dx[i]
    let ny = start.y + dy[i]
    
    if !inRange(nx, ny) { continue }
    if board[ny][nx] > board[start.y][start.x] {
      for y in 0..<n {
        print(dp[y])
      }
      print("")
      dp[start.y][start.x] = max(dp[start.y][start.x], dfs(start: (nx, ny))+1)
    }
  }
  
  return dp[start.y][start.x]
}

var ans = 0
for y in 0..<n {
  for x in 0..<n {
    ans = max(ans, dfs(start: (x,y)))
  }
}

print(ans)

