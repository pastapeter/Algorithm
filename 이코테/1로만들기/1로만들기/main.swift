//
//  main.swift
//  1로만들기
//
//  Created by Jung peter on 9/3/22.
//

import Foundation

var input = Int(readLine()!)!

var dp = [Int](repeating: 0, count: 30001)

for i in 2...input {
    
    dp[i] = dp[i-1] + 1
    
    if i % 2 == 0 {
        dp[i] = min(dp[i], dp[i/2] + 1)
    }
    if i % 3 == 0 {
        dp[i] = min(dp[i], dp[i/3] + 1)
    }
    if i % 5 == 0 {
        dp[i] = min(dp[i], dp[i/5] + 1)
    }
}

print(dp[input])

