//
//  main.swift
//  ps14890
//
//  Created by Jung peter on 3/13/23.
//

import Foundation

let nl = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nl[0]
let l = nl[1]
var board: [[Int]] = []
var ans = 0

for _ in 0..<n {
  board.append(readLine()!.split(separator: " ").map { Int(String($0))!})
}

func check() {
  for y in 0..<n {
    if checkele(board: board[y]) { ans += 1}
  }
  
  for x in 0..<n {
    var temp: [Int] = []
    for y in 0..<n {
      temp.append(board[y][x])
    }
    if checkele(board: temp) { ans += 1}
  }
}


func checkele(board: [Int]) -> Bool {
  var used: [Bool] = [Bool](repeating: false, count: n)
  for x in 1..<n {
    if abs(board[x] - board[x-1]) > 1 {
      return false
    }
    if board[x] < board[x-1] {
      for k in 0..<l {
        if x+k >= n || used[x+k] || board[x] != board[x+k] {
          return false
        }
        if board[x] == board[x+k] {
          used[x+k] = true
        }
      }
    } else if board[x] > board[x-1] {
      for k in 0..<l {
        if x-k-1 < 0 || used[x-k-1] || board[x-1] != board[x-k-1] {
          return false
        }
        if board[x-1] == board[x-k-1] {
          used[x-k-1] = true
        }
      }
    }
  }
  return true
}

check()
print(ans)

