//
//  main.swift
//  class101_test
//
//  Created by Jung peter on 1/6/23.
//

import Foundation

func pattern(p: [String]) -> [Int] {
  var j = 0
  var pi = [Int](repeating: 0, count: p.count)
  for i in 1..<p.count {
    while j>0 && p[i] != p[j] {
      j = pi[j-1]
    }
    if p[i] == p[j] {
      j += 1
      pi[i] = j
    }
  }
  return pi
}

func KMP(sArr: [String], pArr: [String]) -> Bool {
  let pi = pattern(p: pArr)
  var j = 0
  for i in sArr.indices {
    while j > 0 && (sArr[i] != pArr[j]) {
      j = pi[j-1]
    }
    if sArr[i] == pArr[j] {
      if j == pArr.count - 1{
        return true
      } else {
        j += 1
      }
    }
  }
  return false
}

public func solution(_ A: inout [String], _ B: inout [String], _ P: inout String) -> String {
  
  var pattern = P.map { String($0)}
  var isContained: [String] = []
  
  B.enumerated().forEach { index, phoneNumber in
    let phoneNumberArr = phoneNumber.map { String($0) }
    if KMP(sArr: phoneNumberArr, pArr: pattern) == true {
      isContained.append(A[index])
    }
  }
  
  if isContained.isEmpty {return "NO CONTACT"}
  
  return isContained.min() ?? "NO CONTACT"
  
}

var a: [String] = ["snader", "amy", "ann", "michael"]
var b: [String] = ["123456789", "234567890", "789123456", "123123123"]


