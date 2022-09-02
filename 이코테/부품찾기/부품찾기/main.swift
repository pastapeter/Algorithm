//
//  main.swift
//  부품찾기
//
//  Created by Jung peter on 9/2/22.
//

import Foundation

func binarySearch(arr: [Int], target: Int, start: Int, end: Int) -> Int? {
    var end = end
    var start = start
    while start <= end {
        let mid = (start + end) / 2
        if arr[mid] == target {
            return mid
        } else if arr[mid] > target {
            end = mid - 1
        } else {
            start = mid + 1
        }
    }
    return nil
}


let n = Int(readLine()!)!
let nArr = readLine()!.split(separator: " ").map {Int($0)!}
let m = Int(readLine()!)!
let mArr = readLine()!.split(separator: " ").map {Int($0)!}

for ele in mArr {
    if let result = binarySearch(arr: nArr, target: ele, start: 0, end: n-1) {
        print("yes", terminator: " ")
    } else {
        print("no", terminator: " ")
    }
}
