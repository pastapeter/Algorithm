//
//  main.swift
//  Greedy_4
//
//  Created by Jung peter on 8/18/22.
//

import Foundation

let condition = readLine()!.split(separator: " ").map{Int($0)!}
var n = condition[0]
let k = condition[1]
var result = 0

//방법1
//while n > 0 {
//    if n % k != 0 {
//        n -= 1
//    } else {
//        n /= k
//    }
//    if n == 0 {
//        break
//    }
//    result += 1
//}

//방법2
while n > 0 {
    let mode = n % k
    result += mode
    n = n - mode
    if n <= 0 {
        break
    }
    n /= k
    result += 1
    
}
result -= 1

print(result)
