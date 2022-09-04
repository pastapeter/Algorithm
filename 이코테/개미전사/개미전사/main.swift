//
//  main.swift
//  개미전사
//
//  Created by Jung peter on 9/3/22.
//

import Foundation

var dp = [Int](repeating: 0, count: 101)
let input = Int(readLine()!)!
let foods = readLine()!.split(separator: " ").map { Int($0)!}

for (index, food) in foods.enumerated() {
    if index == 0 || index == 1 {
        dp[index + 1] = food
    } else {
        dp[index + 1] = max(dp[index], dp[index - 1] + food)
    }
}

print(dp[input])
