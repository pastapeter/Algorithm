//
//  main.swift
//  ps18430
//
//  Created by Jung peter on 2/27/23.
//

/*
 전형적인 백트래킹 문제이다. 하지만 처음 풀때 꽤 헤맸고 항상 백트래킹은 헤매는듯,,
 백트래킹을 돌릴때, 부메랑이 하나를 차지하고 나면, 방문하지 않은 곳 중에서 하나씩 가운데다 돌려가면서 되는지 확인하면서 백트래킹을 돌렸는데, 여지없이 바로 시간초과가 났다.
 백트래킹의 시간초과가 어느정도되려나
 NM!정도 되려나...?
 그래서 다른 풀이방법은 [][][] <- 여기서 ->->->
                        [][][]           ->->-> 이렇게 가는 형식이다.
 그래서 백트래킹 함수 맨앞에
 if x == m {
   x = 0
   y += 1
 }
 를 둔다.
 
 for i in 0..<4  {
   let cells = getCells(x, y, i)
   if cells.isEmpty  { continue }
   cells.forEach { visited[$0.1][$0.0] = true}
   let sum = board[cells[0].1][cells[0].0] + 2*board[cells[1].1][cells[1].0] + board[cells[2].1][cells[2].0]
   backtracking(x+1, y, total: total+sum)
   cells.forEach { visited[$0.1][$0.0] = false}
 }
 // 또한번 헤맨 부분은 여기다
 위에서 일단 부메랑 돌리면서 fit되는지 확인하고, 되면 backtracking 함수를 활용해서
 옆으로 이동한다. 근데 그 아래 백트래킹은 또 왜해줘야하는가???
 이유는 만약에 4방향 모두 안돌아가면, 한칸옆에서 돌려야하기 때문이다.
 전철타러가면서 생각난 아이디어...ㅋㅋ 
 backtracking(x+1, y, total: total)
 */

import Foundation

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


func backtracking(_ x: Int, _ y: Int, total: Int) {
  var x = x
  var y = y
  if x == m {
    x = 0
    y += 1
  }
  if y == n {
    ans = max(ans, total)
    return
  }
  
  for i in 0..<4  {
    let cells = getCells(x, y, i)
    if cells.isEmpty  { continue }
    cells.forEach { visited[$0.1][$0.0] = true}
    let sum = board[cells[0].1][cells[0].0] + 2*board[cells[1].1][cells[1].0] + board[cells[2].1][cells[2].0]
    backtracking(x+1, y, total: total+sum)
    cells.forEach { visited[$0.1][$0.0] = false}
  }
  backtracking(x+1, y, total: total)
}

if n >= 2 && m >= 2 {
  backtracking(0, 0, total: 0)
} else {
  ans = 0
}

print(ans)
