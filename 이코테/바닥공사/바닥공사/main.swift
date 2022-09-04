//
//  main.swift
//  바닥공사
//
//  Created by Jung peter on 9/4/22.
//

import Foundation

var dp = [Int](repeating: 0, count: 1001)
let input = Int(readLine()!)!
dp[1] = 1
dp[2] = 3

if input == 1 || input == 2 {
    print(dp[input])
} else {
    for i in 3...input {
        dp[i] = 2 * dp[i-2] + dp[i-1]
    }
    print(dp[input])
}


