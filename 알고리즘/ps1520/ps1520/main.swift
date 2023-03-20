//
//  main.swift
//  ps1520
//
//  Created by Jung peter on 3/20/23.
//

/*
 500 * 500 = 250000
 */

import Foundation

struct Coor: Hashable {
  var x: Int
  var y: Int
}

let mn = readLine()!.split(separator: " ").map { Int(String($0))!}
let m = mn[0]
let n = mn[1]
let dx = [-1,1,0,0]
let dy = [0,0,-1,1]
var visited: Set<Coor> = []
var board: [[Int]] = []
var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
var cnt = 0

for _ in 0..<m {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  board.append(temp)
}

func inRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < n && y >= 0 && y < m
}

func dfs(start: Coor) -> Int {
  
  if start == Coor(x: n-1, y: m-1) {
    return 1
  }
  if visited.contains(start) {
    return dp[start.y][start.x]
  }
  
  visited.insert(start)
  for i in 0..<4 {
    let nx = start.x + dx[i]
    let ny = start.y + dy[i]
    
    if !inRange(nx, ny) { continue }
    if board[start.y][start.x] > board[ny][nx] {
      dp[start.y][start.x] += dfs(start: Coor(x: nx, y: ny))
    }
    
  }
  
  return dp[start.y][start.x]
}

print(dfs(start: Coor(x: 0, y: 0)))



