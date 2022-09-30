//
//  main.swift
//  11054 바이토닉부분수열
//
//  Created by abc on 2022/03/01.
//

import Foundation

let input = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").map { Int(String($0))!}
arr.insert(0, at: 0)

var dp1 = [Int](repeating: 0, count: input + 1)
var dp2 = [Int](repeating: 0, count: input + 1)

//가장 증가하는 긴 부분수열
for index in 1...input {
  dp1[index] = 1
  for left in 1...index {
    if arr[left] < arr[index] && dp1[index] < dp1[left] + 1 {
      dp1[index] = dp1[left] + 1
    }
  }
}

//감소하는 가장 긴 부분수열
for index in (1...input).reversed() {
  dp2[index] = 1
  for right in (index...input).reversed(){
    if arr[right] < arr[index] && dp2[index] < dp2[right] + 1 {
      dp2[index] = dp2[right] + 1
    }
  }
}

for i in 0...input {
  dp1[i] = dp1[i] + dp2[i] - 1
}

print(dp1.max()!)




