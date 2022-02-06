//
//  main.swift
//  5052_전화번호목록
//
//  Created by abc on 2022/01/23.
//

import Foundation

func solution2(_ turn: Int) -> String {
  let count =  Int(readLine()!)!
  var arr = [String]()
  for _ in 0..<count {
    arr.append(readLine()!)
  }
  arr.sort()
  for i in 0..<count-1 {
    if arr[i+1].hasPrefix(arr[i]) {
        return "NO"
    }
  }
  return "YES"
}

let turn = Int(readLine()!)!
var answer = [String]()
for i in 0..<turn {
  answer.append(solution2(i))
}
for answer in answer {
  print(answer)
}
