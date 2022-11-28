//
//  main.swift
//  12026
//
//  Created by Jung peter on 11/26/22.
//

import Foundation


let N = Int(readLine()!)!
var route = readLine()!.map { String($0)}
var dp = [Int](repeating: -1, count: N+1)
var order = ["B":"O", "O":"J", "J":"B"]
dp[1] = 0

for i in 0..<route.count {
    for j in i+1..<route.count {
        if route[j] == order[route[i]]! {
            dp[j+1] = min(dp[j+1], (j-i)*(j-i))
        }
    }
}

print(dp)
