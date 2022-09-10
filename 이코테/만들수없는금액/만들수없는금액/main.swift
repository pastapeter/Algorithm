//
//  main.swift
//  만들수없는금액
//
//  Created by Jung peter on 9/10/22.
//

import Foundation

let n = Int(readLine()!)
var coins = readLine()!.split(separator: " ").map { Int($0)!}
coins = coins.sorted()
var result = 1

for coin in coins {
    if result < coin {
        break
    }
    result += coin
}

print(result)



