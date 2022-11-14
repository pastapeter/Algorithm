//
//  main.swift
//  resign2
//
//  Created by Jung peter on 11/14/22.
//

import Foundation

struct Consult {
    var T:Int
    var P: Int
}

let n = Int(readLine()!)!

var schedule: [Consult] = []
var dp = [Int](repeating: 0, count: n+1)


for _ in 1...n {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    schedule.append(Consult(T: input[0], P: input[1]))
}

var k = 0
for i in (0..<n) {
    k = max(k, dp[i])
    if i + schedule[i].T > n {
        continue
    }
    dp[i+schedule[i].T] = max(k + schedule[i].P, dp[i + schedule[i].T])
}

print(dp.max()!)




