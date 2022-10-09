//
//  main.swift
//  만들수없는금액2차시도
//
//  Created by Jung peter on 10/5/22.
//

import Foundation

let n = Int(readLine()!)!
var coins = readLine()!.split(separator: " ").map { Int(String($0))!}

coins.sort()

func solution(_ coins: [Int], _ target: Int) -> Int {
    
    var result = 0
    var coinSum : Set<Int> = []
    
    if !coins.contains(1) {
        return 1
    }
    
    for i in coins.indices {
        for j in i..<coins.count {
            coinSum.insert(coins[i...j].reduce(0, +))
        }
    }
    
    for coin in coinSum.sorted() {
        let temp = result + 1
        if temp == coin {
            result = temp
        } else {
            break
        }
    }
    
    return result + 1
}

func solution2(_ coins: [Int], _ target: Int) -> Int {
    var maxCoin = 1
    for coin in coins {
        if maxCoin < coin {
            break
        }
        maxCoin += coin
    }
    return maxCoin
} 


print(solution2(coins, n))
