//
//  main.swift
//  2805
//
//  Created by abc on 2021/06/27.
//

import Foundation

let input = readLine()!.split(separator: " ").compactMap{ Int(String($0))}
let N = input[0]
let M = input[1]

var result = 0
var result2 = 0

var trees = readLine()!.split(separator: " ").compactMap{ Int(String($0)) }

trees = trees.sorted()

var first = 0
var last = trees[N-1]
var mid = 0


while(first <= last){
    mid  = (first+last) / 2
    result = 0
    for i in trees{
        if i - mid > 0 {
            result += i - mid
        }
    }
   if result < M{
        last = mid-1
    } else {
        first = mid+1
        result2 = mid
    }
}
print(result2)


