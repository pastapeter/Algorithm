//
//  main.swift
//  ps2512
//
//  Created by Jung peter on 2/10/23.
//

import Foundation

let n = Int(readLine()!)!
var cities = readLine()!.split(separator: " ").map { Int(String($0))!}.sorted()
var deposit = Int(readLine()!)!
let total = cities.reduce(0, +)
let pivot = deposit / n

func solve() -> Int {
  
  if deposit == total {
    return cities.max()!
  }
  
  var left = 0
  var right = cities.last!
  var result = 0
  
  while left <= right {
    var mid = (left + right) / 2
    
    var total = 0
    for city in cities {
      total += min(mid, city)
    }
    
    if total > deposit {
      right = mid - 1
    } else {
      result = mid
      left = mid + 1
    }
  }
  
  return result
}


print(solve())
