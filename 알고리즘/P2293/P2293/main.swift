//
//  main.swift
//  P2293
//
//  Created by Jung peter on 11/16/22.
//

import Foundation

let nk = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nk[0]
let k = nk[1]
var dp = [Int](repeating: 0, count: k+1)
dp[0] = 1
var coins: [Int] = []
for _ in 0..<n {
    coins.append(Int(readLine()!)!)
}
coins.sort()

for coin in coins {
    for j in stride(from: coin, through: k, by: 1) {
        if dp[j] + dp[j-coin] >= Int(pow(2.0, 31.0)) {dp[j] = 0}
        dp[j] += dp[j-coin]
    }
}

print(dp[k])
