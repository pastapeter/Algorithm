//
//  main.swift
//  11053가장긴부분수열
//
//  Created by abc on 2022/03/01.
//

import Foundation

let input = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map {Int(String($0))!}

var dp = [Int](repeating: 0, count: input)
for index in 0..<input {
  dp[index] = 1
  for j in 0...index {
    if arr[j] < arr[index] && dp[index] < dp[j] + 1 {
      dp[index] = dp[j] + 1
    }
  }
}

print(dp.max()!)


