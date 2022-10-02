//
//  main.swift
//  antenna
//
//  Created by Jung peter on 10/2/22.
//

import Foundation

let n = Int(readLine()!)!
var input = readLine()!.split(separator: " ").map {Int(String($0))!}

input.sort()

print(input[input.count / 2 - 1])



