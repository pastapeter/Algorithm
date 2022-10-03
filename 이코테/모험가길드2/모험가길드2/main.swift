//
//  main.swift
//  모험가길드2
//
//  Created by Jung peter on 10/4/22.
//

import Foundation

let n = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").map { Int(String($0))!}

arr.sort()
var count = 0
var group = [Int]()
var result = 0

for i in arr {
    count += 1
    if count >= i {
        result += 1
        count = 0
    }
}

print(result)


