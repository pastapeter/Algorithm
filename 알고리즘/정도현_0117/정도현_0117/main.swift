//
//  main.swift
//  정도현_0117
//
//  Created by Jung peter on 2/7/23.
//

import Foundation

struct Coor: Hashable {
  var x: Int
  var y: Int
}

let dx = [1, -1, 1, -1]
let dy = [1, 1, -1, -1]
let n = Int(readLine()!)!
var board = [[Int]]()
for _ in 0..<n {
  board.append(readLine()!.split(separator: " ").map{ Int(String($0))!})
}

func solve() {
  
  var coorSet: Set<Coor> = []
  var result = 0
  
  for y in 0..<n {
    for x in 0..<n {
      if board[y][x] == 1 {
        coorSet.insert(Coor(x: x, y: y))
      }
    }
    print(result)
  }
  
  for coor in coorSet {
    result = max(result, dfs(start: coor, board: board, coorset: coorSet, cnt: 1))
  }
  
  
}

func dfs(start: Coor, board: [[Int]], coorset: Set<Coor>, cnt: Int) -> Int {
  
  //0으로 일단 다 만들어야지
  
  
  if coorset.isEmpty { return cnt }
  var newCnt = cnt + 1
  var newboard = board
  var newcoorset = coorset
  var result = 0
  
  for i in 0..<4 {
    fillNotAvailable(coor: start, board: &newboard, dx: dx[i], dy: dy[i], coorset: &newcoorset, cnt: newCnt)
  }
  
  for y in 0..<n {
    print(newboard[y])
  }
  print("\n")
  
  
  while !newcoorset.isEmpty {
    var coor = newcoorset.removeFirst()
    print(dfs(start: coor, board: newboard, coorset: newcoorset, cnt: newCnt))
  }
  
  return cnt

}

func fillNotAvailable(coor: Coor, board: [[Int]], dx: Int, dy: Int, coorset: inout Set<Coor>, cnt: Int) -> [[Int]] {
  var newboard = board
  if coor.y < 0 || coor.x < 0 || coor.y >= n || coor.x >= n {
    return newbopa
  
  }
  if board[coor.y][coor.x] > 1 { return board }
  board[coor.y][coor.x] = cnt
  coorset.remove(coor)
  fillNotAvailable(coor: Coor(x: coor.x + dx, y: coor.y + dy), board: &board, dx: dx, dy: dy, coorset: &coorset, cnt: cnt)
}

solve()
