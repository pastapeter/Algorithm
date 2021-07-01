//
//  main.swift
//  10815
//
//  Created by abc on 2021/07/02.
//

import Foundation

var N = Int(readLine()!)!
var arr1 = readLine()!.components(separatedBy: " ").map({Int($0)!})
var M = Int(readLine()!)!
var arr2 = readLine()!.components(separatedBy: " ").map {Int($0)!}

arr1.sort()

func bsearch(_ left: inout Int, _ right: inout Int, _ target: Int) -> Bool{
    while(left <= right){
        let mid = (left+right) / 2
        if arr1[mid] == target {
            return true
        } else if (target < arr1[mid]){
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return false
}

var result = [String]()


for i in 0..<arr2.count{
    var start = 0
    var end = arr1.count-1
    if bsearch(&start, &end, arr2[i]) {
        result.append("1")
    } else {
        result.append("0")
    }
}
print(result.joined(separator: " "))



