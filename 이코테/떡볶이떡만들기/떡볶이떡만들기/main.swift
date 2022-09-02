//
//  main.swift
//  떡볶이떡만들기
//
//  Created by Jung peter on 9/3/22.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)!}
let n = nm[0]
let m = nm[1]
let input = readLine()!.split(separator: " ").map { Int($0)!}

func binearySearch(arr: [Int], target: Int, start: Int, end: Int) -> Int? {
    var start = start
    var end = end
    while start <= end {
        let mid = (start + end) / 2
        var result = 0
        
        for ele in input {
            if ele - arr[mid] > 0 {
                result += ele - arr[mid]
            }
        }
        
        if result == m {
            return mid
        } else if result >= m {
            start = mid + 1
        } else {
            end = mid - 1
        }
    }
    return nil
}

let max = input.max()!
let min = input.min()!
var newArr: [Int] = []

for i in min...max {
    newArr.append(i)
}

if let index = binearySearch(arr: newArr, target: m, start: 0, end: newArr.count - 1) {
    print(newArr[index])
}

