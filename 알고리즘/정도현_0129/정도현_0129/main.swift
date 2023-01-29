//
//  main.swift
//  정도현_0129
//
//  Created by Jung peter on 1/30/23.
//

import Foundation

let N = Int(readLine()!)!
let developers = readLine()!.split(separator: " ").map { Int(String($0))! }

var start = 0
var end = N - 1
var result = (N - 2) * min(developers[start], developers[N-1])

func calculate(start: Int, end: Int) -> Int {
  return (end - start - 1) * min(developers[start], developers[end])
}

while start < end {
  
  result = max(result, calculate(start: start, end: end))
  
  if developers[start] < developers[end] {
    start += 1
  } else {
    end -= 1
  }
  
}

print(result)

