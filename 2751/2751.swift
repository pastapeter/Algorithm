//
//  main.swift
//  2751
//
//  Created by abc on 2021/03/17.
//

import Foundation

var input = Int(readLine()!)!
var arr = [Int]()


for i in 0..<input {
    arr.append(Int(readLine()!)!)
}
arr.sort()
arr.forEach { print($0)}
