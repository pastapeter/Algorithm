	//
//  main.swift
//  숨바꼭질2
//
//  Created by Jung peter on 12/17/22.
//

import Foundation

struct Move {
  var point: Int
  var count: Int
}

let NK = readLine()!.split(separator: " ").map { Int(String($0))!}
let N = NK[0]
let K = NK[1]
var lineMap = [Int](repeating: 0, count: 1000001)
lineMap[N] = 1
lineMap[K] = 2

let moveFunc: [(Int)-> Int] = [{i in return i-1}, {i in return i+1}, {i in return 2*i}]
var result: [Move] = []
// 4 8 16 17

func bfs(start: Move) {
  var queue: [Move] = [start]
  while !queue.isEmpty {
    let now = queue.removeFirst()
    if now.point == K {
      result.append(now)
    }
    for move in moveFunc {
      var new = move(now.point)
      if new < 0 || new > 2*K {continue}
      if lineMap[new] != 1 {
        lineMap[new] = 1
        queue.append(Move(point: new, count: now.count + 1))
      }
    }
  }
  print(result)
}

func solution(){
  let start = Move(point: N, count: 0)
  bfs(start: start)
}

solution()






