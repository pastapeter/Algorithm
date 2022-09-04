//
//  main.swift
//  떡볶이떡만들기2
//
//  Created by Jung peter on 9/3/22.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)!}
let n = nm[0]
let m = nm[1]
let input = readLine()!.split(separator: " ").map { Int($0)!}

var start = 0
var end = input.max()!
var result = 0

while(start <= end) {
    var total = 0
    let mid = (start + end) / 2
    for x in input {
        if x > mid {
            total += x - mid
        }
    }
    if total < m {
        end = mid - 1
    } else {
        result = mid
        start = mid + 1
    }
}

print(result)
