//
//  main.swift
//  skplanet3
//
//  Created by Jung peter on 3/1/23.
//

import Foundation

var n = Int(readLine()!)!
var a = [[Int]]()
for _ in 0..<n {
  a.append(readLine()!.split(separator: " ").map { Int(String($0))!})
}

let dx = [1,0,-1,0]
let dy = [0,1,0,-1]

var sx = 0
var sy = 0
var totalBlack = 0
for y in 0..<n {
  for x in 0..<n {
    if a[y][x] == 2 {
      sx = x
      sy = y
    }
    if a[y][x] != 0 {
      totalBlack += 1
    }
  }
}

var ans = false;

func inRange(_ x: Int, _ y: Int) -> Bool {
  return (x >= 0 && x < n && y >= 0 && y < n)
}

func getCells(_ x: Int, _ y: Int, _ i: Int) -> (Int, Int, [(Int, Int)]) {
  var res = [(Int, Int)]()
  var x = x
  var y = y
  while true {
    let nx = x + dx[i]
    let ny = y + dy[i]
    if !inRange(nx, ny) || a[ny][nx] != 1 {
      break
    }
    x = nx
    y = ny
    res.append((x, y))
  }
  return (x, y, res)
}

func backtracking(_ x: Int, _ y: Int, _ cnt: Int) { // 지금까지 남긴 흔적의 갯수
  if cnt == totalBlack {
    ans = true
    return
  }
  
  if ans == true { return } // 이미 가능한 방법을 찾았다면, 더 이상 탐색할 필요가 없다.
  
  for i in 0..<4 {
    let temp = getCells(x, y, i) // x,y에서 i 방향으로 이동했을때, 새롭게 남기는 흔적 위치들
    var nx = temp.0
    var ny = temp.1
    var cells = temp.2
    
    if cells.isEmpty {
      continue
    }
    
    // i번 방향으로 이동할때 생기는 흔적남기기
    for (cx, cy) in cells {
      a[cy][cx] = 2
    }
    
    backtracking(ny, ny, cnt + cells.count)
    
    //backtracking은 다시 복원해야하는 작업 필요하니깐
    //k번 방향으로 이동할때 생기는 흔적 복원하기
    for (cx, cy) in cells {
      a[cy][cx] = 0
    }
    
  }
  
}

backtracking(sx, sy, 1)

if ans {
  print("YES")
} else { print("NO")}




