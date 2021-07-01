//
//  main.swift
//  18310
//
//  Created by abc on 2021/07/02.
//

import Foundation

var num = Int(readLine()!)!
var input = readLine()!.components(separatedBy: " ").map({Int($0)!})

input = input.sorted()

var index = input.count / 2
var leftIndex = index - 1
var rightIndex = index + 1

print(min(input[index], input[leftIndex], input[rightIndex]))
