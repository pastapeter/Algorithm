//
//  main.swift
//  2133
//
//  Created by abc on 2022/02/19.
//

import Foundation

var input = Int(readLine()!)!

var dp = [Int](repeating: 0, count: input + 1)

//식 a[i] = a[i-1] * 3 + a[i-2] * 2 ... 1*2
if input >= 2 {
  dp[0] = 1
  for i in (2...input) {
    if !i.isMultiple(of: 2) { continue }
    else { // 2의 배수다
      for j in stride(from: i - 2, through: 0, by: -2) {
        if j == i - 2 {
          dp[i] += dp[j] * 3
        } else {
          dp[i] += dp[j] * 2
        }
      }
    }
  }
}

print(dp[input])

