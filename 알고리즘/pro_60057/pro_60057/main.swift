//
//  main.swift
//  pro_60057
//
//  Created by Jung peter on 2/15/23.
//

import Foundation


func solution(_ s:String) -> Int {
  
  var strArr = s.map { String($0)}
  let len = strArr.count
  let limit = len / 2
  var results: [String] = []
  
  if strArr.count == 1 { return 1}
  
  for i in 1...limit {
    var stack: [String] = []
    var tempResult = ""
    var lastidx = 0
    for j in stride(from: 0, through: len, by: i) {
      if j == 0 { continue }
      let sliced = strArr[j-i..<j].joined()
      if stack.isEmpty {
        stack.append(sliced)
      } else if stack.last! == sliced {
        stack.append(sliced)
      } else if stack.last! != sliced {
        tempResult += "\(stack.count > 1 ? String(stack.count) : "" )\(stack.last!)"
        stack.removeAll()
        stack.append(sliced)
      }
      lastidx = j
    }
    if stack.count > 1 {
      tempResult += "\(stack.count)\(stack.last!)"
    } else {
      tempResult += stack.joined()
    }
    tempResult += strArr[lastidx...].joined()
    results.append(tempResult)
  }
  
  return results.map { $0.count }.min()!
  
}

solution("ababc")
