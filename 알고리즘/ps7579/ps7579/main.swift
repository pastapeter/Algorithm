//
//  main.swift
//  ps7579
//
//  Created by Jung peter on 2/24/23.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]
var memories = readLine()!.split(separator: " ").map { Int(String($0))!}
var costs = readLine()!.split(separator: " ").map { Int(String($0))!}
costs.insert(0, at: 0)
memories.insert(0, at: 0)

var dp = [[Int]](repeating: [Int](repeating: 0, count: 101 * 100), count: n+1)

for y in 1...n {
  for x in 0...costs.reduce(0, +) {
    if x >= costs[y] {
      dp[y][x] = max(dp[y][x], dp[y-1][x-costs[y]] + memories[y])
    }
    dp[y][x] = max(dp[y-1][x], dp[y][x])
  }
}


for i in dp[n].indices {
  if dp[n][i] >= m {
    print(i)
    break
  }
}
