//
//  main.swift
//  ps22233
//
//  Created by Jung peter on 2/10/23.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]
var memo: Set<String> = []
var blog: Set<String> = []
var result: [Int] = []

for _ in 0..<n {
  memo.insert(readLine()!)
}

for turn in 0..<m {
  readLine()!.split(separator: ",").forEach {
    blog.insert(String($0))
  }
  result.append(memo.subtracting(blog).count)
}

result.forEach { print($0)}
