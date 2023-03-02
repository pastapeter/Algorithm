//
//  main.swift
//  ps18430
//
//  Created by Jung peter on 2/27/23.
//

import Foundation

/*
 2 3
 7 5 4
 3 2 9
 */

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]
var board: [[Int]] = []
var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)

for _ in 0..<n {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
  board.append(temp)
}

var totalCount: Int = (n*m)/3
var ans = 0
let dx = [(-1,0), (-1,0), (0, 1), (1, 0)]
let dy = [(0, 1), (0, -1), (-1, 0), (0, 1)]

func inRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < m && y >= 0 && y < n && visited[y][x] == false
}

func getCells(_ x: Int, _ y: Int, _ dir: Int) -> [(Int, Int)] {
  if !(inRange(x, y) && inRange(x+dx[dir].0, y+dy[dir].0) && inRange(x+dx[dir].1, y+dy[dir].1)) {
    return []
  }
  if visited[y][x] == true {return []}
  return [(x+dx[dir].0, y+dy[dir].0),(x, y), (x+dx[dir].1, y+dy[dir].1)]
}


func backtracking(_ x: Int, _ y: Int, cnt: Int, total: Int) {
  
  if totalCount == cnt {
    return
  }
  
  for i in 0..<4  {
    
    let cells = getCells(x, y, i)
    for cell in cells {
      visited[cell.1][cell.0] = true
    }
    if cells.isEmpty  { continue }
    let sum = board[cells[0].1][cells[0].0] + 2*board[cells[1].1][cells[1].0] + board[cells[2].1][cells[2].0]
    ans = max(ans, total+sum)
    backtracking(x, y+1, cnt: cnt+1, total: total+sum)
    backtracking(x-1, y, cnt: cnt+1, total: total+sum)
    backtracking(x, y-1, cnt: cnt+1, total: total+sum)
    backtracking(x+1, y, cnt: cnt+1, total: total+sum)
    for cell in cells {
      visited[cell.1][cell.0] = false
    }
  }
  
}

backtracking(0, 0, cnt: 0, total: 0)


print(ans)
