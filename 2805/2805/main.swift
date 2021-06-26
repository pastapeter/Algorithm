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

var trees = readLine()!.split(separator: " ").compactMap{ Int(String($0)) }

trees = trees.sorted()

var first = trees[0]
var last = trees[N-1]
var mid  = (first+last) / 2


while(first < last){
    result = 0
    for i in trees{
        if i - mid > 0 {
            result += i - mid
        }
    }
    if result == M {
        print(mid)
        break
    } else if result < M{
        last = mid-1
    } else if result > M {
        first = mid+1
    }
    mid  = (first+last) / 2
}


