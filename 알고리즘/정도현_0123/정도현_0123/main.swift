//
//  main.swift
//  정도현_0123
//
//  Created by Jung peter on 1/23/23.
//

import Foundation

let N = Int(readLine()!)!
let stones = readLine()!.split(separator: " ").map { Int(String($0))! }

func solution(stone: [Int]) -> Int {
  var now = 0
  var sum = 0
  for i in stone {
    now += i
    if now < 0 {
      now = 0
    }
    if sum < now {
      sum = now
    }
  }
  return sum
}

let stone1 = stones.map { return $0 == 2 ? -1 : 1 }
let stone2 = stones.map { return $0 == 2 ? 1 : -1 }

print(max(solution(stone: stone1), solution(stone: stone2)))









