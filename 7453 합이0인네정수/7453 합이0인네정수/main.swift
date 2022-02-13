//
//  main.swift
//  7453 합이0인네정수
//
//  Created by abc on 2022/02/13.
//

import Foundation

let input = Int(readLine()!)!
var A = [Int]()
var B = [Int]()
var C = [Int]()
var D = [Int]()
for _ in 0..<input {
  let nums = readLine()!.split(separator: " ").map { Int(String($0))!}
  A.append(nums[0])
  B.append(nums[1])
  C.append(nums[2])
  D.append(nums[3])
}
var result = 0
var AB = [Int]()
var CD = [Int]()

for i in 0..<input {
  for j in 0..<input {
    AB.append(A[i] + B[j])
    CD.append(C[i] + D[j])
  }
}
AB.sort(by:<)
CD.sort(by:<)

for ab in AB {
  let upper = upperBound(CD, -ab) // upper는 0 되는 다음꺼
  let lower = lowerBound(CD, -ab) // lower는 0 되는 전꺼
  result += (upper - lower)
}
print(result)


func upperBound(_ arr: [Int], _ target: Int) -> Int {
  var left = 0
  var right = arr.count
  while(left<right) {
    var mid = (left + right) / 2
    if arr[mid] <= target {
      left = mid + 1
    } else {
      right = mid
    }
  }
  return right
}

func lowerBound(_ arr: [Int], _ target: Int) -> Int {
  var left = 0
  var right = arr.count
  while(left < right) {
    var mid = (left + right) / 2
    if arr[mid] >= target {
      right = mid
    } else {
      left = mid + 1
    }
  }
  return right
}
