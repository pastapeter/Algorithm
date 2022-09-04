//
//  main.swift
//  효율적인화폐구성2
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
for _ in 0..<n {
    coins.append(Int(readLine()!)!)
}
coins.sort()

for i in 0..<n {
    for j in coins[i]..<m+1 {
        if dp[j - coins[i]] != Int.max {
            dp[j] = min(dp[j], dp[j-coins[i]] + 1)
        }
    }
}

if dp[m] == Int.max {
    print(-1)
} else {
    print(dp[m])
}
