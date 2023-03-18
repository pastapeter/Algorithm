//
//  main.swift
//  ps12886
//
//  Created by Jung peter on 3/18/23.
//

import Foundation

struct Rock: Hashable {
  var r1: Int
  var r2: Int
  var r3: Int
}

var input = readLine()!.split(separator: " ").map { Int(String($0))!}
var rocks = Rock(r1: input[0], r2: input[1], r3: input[2])
let total = rocks.r1 + rocks.r2 + rocks.r3
var visited: Set<Rock> = []
var ans = 0
func bfs() -> Int {
  var queue = [rocks]
  visited.insert(rocks)
  var index = -1
  while index < queue.count-1 {
    index += 1
    var poped = queue[index]
    if poped.r1 == poped.r2 && poped.r2 == poped.r3 {
      return 1
    }
    for (x, y) in [(poped.r1, poped.r2), (poped.r2, poped.r3), (poped.r1, poped.r3)] {
      var x = x
      var y = y
      if x == y { continue }
      else if x < y {
        y -= x
        x += x
      } else if x > y {
        x -= y
        y += y
      }
      var z = total - x - y
      if !visited.contains(Rock(r1: x, r2: y, r3: z)) {
        visited.insert(Rock(r1: x, r2: y, r3: z))
        queue.append(Rock(r1: x, r2: y, r3: z))
      }
    }
  }
  return 0
}

if !total.isMultiple(of: 3) {
  print(0)
} else {
  print(bfs())
}

