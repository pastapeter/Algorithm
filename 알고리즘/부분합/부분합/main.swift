//
//  main.swift
//  부분합
//
//  Created by Jung peter on 11/7/22.
//

import Foundation

let ns = readLine()!.split(separator: " ").map { Int(String($0))!}
let arr = readLine()!.split(separator: " ").map { Int(String($0))!}

func solution(n: Int, s: Int, arr: [Int]) -> Int {
    var minLen = Int.max
    var sum = 0
    var start = -1
    var end = 0
    while start < arr.count && end < arr.count {
        start += 1
        if start >= arr.count {break}
        sum += arr[start]
        if sum >= s {
            minLen = min(minLen, start - end + 1)
            sum -= arr[end]
            sum -= arr[start]
            start -= 1
            end += 1
        }
    }
    return minLen == Int.max ? 0 : minLen
}

print(solution(n: ns[0], s: ns[1], arr: arr))


func solution2(n: Int, s: Int, arr: [Int]) -> Int {
    
    var start = 0
    var end = -1
    var sum = 0
    var minLen = Int.max
    
    while start < arr.count && end < arr.count {
        end += 1
        if end >= arr.count {break}
        sum += arr[end]
        if sum >= s {
            minLen = min(minLen, end - start + 1)
            sum -= arr[start]
            sum -= arr[end]
            end -= 1
            start += 1
        }
    }
    
    return minLen == Int.max ? 0 : minLen
}

print(solution2(n: ns[0], s: ns[1], arr: arr))
