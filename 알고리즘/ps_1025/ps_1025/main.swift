//
//  main.swift
//  ps_1025
//
//  Created by Jung peter on 2/17/23.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nm[0]
let m = nm[1]

var board = [[Int]]()

for y in 0..<n {
  board.append(readLine()!.map { Int(String($0))!})
}
var result = Int.min

func isSqrt(_ n: Int) -> Bool {
  let t = Int(sqrt(Double(n)))
  return t*t == n
}

func check(x: Int, y: Int) -> Bool {
  return !(x >= m || x < 0 || y >= n || y < 0)
}

func findSqrt(x:Int, y:Int, xstride: Int, ystride: Int) {
  var y = y
  var x = x
  var number: [Int] = []
  
  while check(x: x, y: y) {
    number.append(board[y][x])
    x += xstride
    y += ystride
  }
  if let newN = Int(number.map { String($0)}.joined()) {
    if isSqrt(newN) {
      result = max(newN, result)
    }
  }
  if let newN2 = Int(number.reversed().map{String($0)}.joined()) {
    if isSqrt(newN2) {
      result = max(newN2, result)
    }
  }
  
  
}

for y in 0..<n {
  for x in 0..<n {
    if isSqrt(board[y][x]) {
      result = max(result, board[y][x])
    }
  }
}


for ystride in 1..<n {
  for xstride in 1..<m {
    for y in stride(from: 0, through: n-1, by: ystride) {
      var number: [Int] = []
      for x in stride(from: 0, through: m-1, by: xstride) {
        if check(x: x, y: y) {
          number.append(board[y][x])
        }
      }
      let newN = Int(number.map { String($0)}.joined())!
      if isSqrt(newN) {
        result = max(newN, result)
      }
      
    }
    
    for y in stride(from: n-1, through: 0, by: -ystride) {
      var number: [Int] = []
      for x in stride(from: m-1, through: 0, by: -xstride) {
        if check(x: x, y: y) {
          number.append(board[y][x])
        }
      }
      let newN = Int(number.map { String($0)}.joined())!
      if isSqrt(newN) {
        result = max(newN, result)
      }
      
    }
    for k in 0..<n {
      findSqrt(x: 0, y: k, xstride: xstride, ystride: ystride)
    }
    
    
    findSqrt(x: n-1, y: m-1, xstride: -xstride, ystride: -ystride)
    findSqrt(x: 0, y: m-1, xstride: xstride, ystride: -ystride)
    findSqrt(x: n-1, y: 0, xstride: -xstride, ystride: ystride)
  
  }
}


if result == Int.min {
  print(-1)
} else {
  print(result)
}
