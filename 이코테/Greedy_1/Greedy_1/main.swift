//
//  main.swift
//  Greedy_1
//
//  Created by Jung peter on 8/18/22.
//

import Foundation

let condition = readLine()!.split(separator: " ").map{ Int($0)!}
let n = condition[0]
var m = condition[1]
let k = condition[2]
let q = readLine()!.split(separator: " ").map{ Int($0)!}.sorted { $0 > $1}
var answer: Int = 0
var index = 0
let newArr = [Int](repeating: q[index], count: k) + [q[index+1]]
let newArrSum = newArr.reduce(0, +)

print((m / (k + 1)) * newArrSum + (m % (k+1)) * q[index])

//
//while m > 0 {
//    for _ in 0..<k {
//        answer += q[index]
//        m -= 1
//        if m == 0 {
//            break
//        }
//    }
//    answer += q[index+1]
//    m -= 1
//}




