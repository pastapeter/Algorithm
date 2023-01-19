//
//  main.swift
//  naverfin2
//
//  Created by Jung peter on 12/17/22.
//

import Foundation

func combi<T>(_ nums: [T], _ targetNum: Int) -> [[T]] {
  var result = [[T]]()
  
  func combination(_ index: Int, _ nowCombi: [T]) {
    if nowCombi.count == targetNum {
      result.append(nowCombi)
      return
    }
    
    for i in index..<nums.count {
      combination(i+1, nowCombi + [nums[i]])
    }
  }
  
  combination(0, [])
  return result
}

func solution(_ gates: [[Int]], _ airlines: [Int]) -> [Int] {
  var gates = gates
  for gate in gates {
    for i in 1..<gate.count {
      
    }
  }
  
  return []
}

