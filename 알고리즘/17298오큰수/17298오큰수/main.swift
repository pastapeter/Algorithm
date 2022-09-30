//
//  main.swift
//  17298오큰수
//
//  Created by abc on 2022/02/10.
//

import Foundation

let num = Int(readLine()!)!
var list = readLine()!.split(separator: " ").map{Int(String($0))!}
var result = [String](repeating: "-1", count: num)
var stack = [Int]()

for i in 0..<num {
  
  while !stack.isEmpty, list[stack.last!] < list[i] {
    let index = stack.removeLast()
    result[index] = "\(list[i])"
  }
  stack.append(i)
}
print(result.joined(separator: " "))



