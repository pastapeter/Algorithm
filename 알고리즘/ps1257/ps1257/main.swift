//
//  main.swift
//  ps1257
//
//  Created by Jung peter on 4/2/23.
//

import Foundation

/*
 N개의 수 중에서 어떤 수가 다른 수 두 개의 합으로 나타낼 수 있다면 그 수를 “좋다(GOOD)”고 한다.
 N개의 수가 주어지면 그 중에서 좋은 수의 개수는 몇 개인지 출력하라.
 수의 위치가 다르면 값이 같아도 다른 수이다.
 */

/*
 사실 그냥 투포인터문제임
 */

let n = Int(readLine()!)!
var nums = readLine()!.split(separator: " ").map { Int(String($0))!}
nums.sort()
var ans = 0

for i in 0..<n {
  let target = nums[i]
  var newNums = nums[0..<i] + nums[i+1..<n]
  var start = 0
  var end = newNums.count - 1
  while start < end {
    if newNums[start] + newNums[end] == target {
      ans += 1
      break
    } else if newNums[start] + newNums[end] < target {
      start += 1
    } else {
      end -= 1
    }
  }
}

print(ans)


