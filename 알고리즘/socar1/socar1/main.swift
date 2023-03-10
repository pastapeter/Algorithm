//
//  main.swift
//  socar1
//
//  Created by Jung peter on 3/7/23.
//

import Foundation

func solution(_ height: [Int], _ width: [Int]) -> Int64 {
  
  var dic: [Int: [Int]] = [:]
  var ansArr: [Int64] = []
  var ans: Int64 = 0
  var tempwidth = 0
  for i in height.indices {
    if dic[height[i]] == nil {
      dic.updateValue([width[i]], forKey: height[i])
    } else {
      dic[height[i]]! += [width[i]]
    }
  }
  var sortedDicArr = dic.sorted { $0.key > $1.key }
  for dic in sortedDicArr {
    tempwidth += dic.value.reduce(0, +)
    ansArr.append(Int64(dic.key * tempwidth))
    ans = max(ans, Int64(dic.key * tempwidth))
  }
  return ans
}

print(solution([140,21,21,32], [2,1,3,7]))
