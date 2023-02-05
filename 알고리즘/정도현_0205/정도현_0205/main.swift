//
//  main.swift
//  정도현_0205
//
//  Created by Jung peter on 2/5/23.
//

import Foundation


func solve() {
  let n = Int(readLine()!)!
  let coins = readLine()!.split(separator: " ").map { Int(String($0))!}
  let target = Int(readLine()!)!
  var dp = [[Int]](repeating: [Int](repeating: 0, count: target+1), count: n)
  for y in coins.indices {
    dp[y][0] = 1
  }
  for x in 1...target {
    for y in coins.indices {
      if y == 0 {
        dp[y][x] = x%coins[y] == 0 ? 1 : 0
      } else {
        if x-coins[y] >= 0 {
          dp[y][x] = dp[y-1][x] + dp[y][x-coins[y]]
        } else {
          dp[y][x] = dp[y-1][x]
        }
      }
    }
  }
  answer.append(dp[n-1][target])
}
let t = Int(readLine()!)!
var answer = [Int]()
for _ in 0..<t {
  solve()
}
answer.forEach {
  print($0)
}


