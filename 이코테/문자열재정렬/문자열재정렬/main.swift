//
//  main.swift
//  문자열재정렬
//
//  Created by Jung peter on 9/12/22.
//

import Foundation

var input = readLine()!.map { String($0) }
input.sort()
var result1: [String] = []
var result2: [String] = []
for ele in input {
    if let num = Int(ele) {
        result1.append(ele)
    } else {
        result2.append(ele)
    }
}
print((result2).joined(separator: "") + "\(result1.map{ Int($0)!}.reduce(0, +))")

