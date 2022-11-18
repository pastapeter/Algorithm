//
//  main.swift
//  P2294
//
//  Created by Jung peter on 11/17/22.
//

import Foundation

let nk = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nk[0]
let k = nk[1]
var dp = [Int](repeating: 100000, count: k+1)
dp[0] = 0
var coins: [Int] = []
for _ in 0..<n {
    coins.append(Int(readLine()!)!)
}
coins.sort()

for i in 0...k{
    for coin in coins {
        if i - coin < 0 {continue}
        dp[i] = min(dp[i-coin]+1, dp[i])
    }
}

if dp[k] > 10000 {
    print(-1)
} else {
    print(dp[k])
}

