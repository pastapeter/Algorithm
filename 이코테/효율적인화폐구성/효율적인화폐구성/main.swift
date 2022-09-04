//
//  main.swift
//  효율적인화폐구성
//
//  Created by Jung peter on 9/4/22.
//

import Foundation

var dp = [Int](repeating: Int.max, count: 100001)
dp[0] = 0
let nm = readLine()!.split(separator: " ").map {Int($0)!}
let n = nm[0]
let m = nm[1]
var coins: [Int] = []
var coinResult = [Int](repeating: Int.max, count: n)
for _ in 0..<n {
    coins.append(Int(readLine()!)!)
}
coins.sort()

for i in 1...m {
    
    if coins.contains(i) {
        dp[i] = 1
    } else {
        for (idx, coin) in coins.enumerated() {
            if i - coin > 0 && dp[i-coin] > 0 && dp[i-coin] != Int.max {
                coinResult[idx] = dp[i-coin] + 1
            }
        }
        dp[i] = coinResult.min() ?? Int.max
    }
    
}

if dp[m] == Int.max {
    print(-1)
} else {
    print(dp[m])
}

