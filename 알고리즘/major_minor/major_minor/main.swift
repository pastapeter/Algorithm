//
//  main.swift
//  major_minor
//
//  Created by Jung peter on 11/7/22.
//

import Foundation

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map {Int(String($0))!}

let sorted = arr.sorted()
print("\(sorted[0]) \(sorted[n-1])")

