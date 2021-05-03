//
//  main.swift
//  2750
//
//  Created by abc on 2021/03/16.
//

import Foundation

var arr = [Int]()
var input = Int(readLine()!)!

for _ in 0..<input {
    arr.append(Int(readLine()!)!)
}
arr.sort()
for e in arr {
  print(e)
}

