//
//  main.swift
//  정도현_0126
//
//  Created by Jung peter on 1/26/23.
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

func solution(_ relation:[[String]]) -> Int {
  // 1개짜리 찾기
  var rowCount = relation.count
  var colCount = relation[0].count
  var indexs: [Int] = (0..<relation[0].count).map { $0 }
  var dp: Set<Set<Int>> = []
  
  for index in indexs {
    var tempSet = Set<String>()
    for row in relation {
      tempSet.insert(row[index])
    }
    if tempSet.count == rowCount {
      dp.insert(Set([index]))
    }
  }
  
  var keyLength = 2
  
  while keyLength <= colCount {
    
    var combis = combi(indexs, keyLength)
    var newCombis: [[Int]] = []
    
    for combi in combis {
      var flag = false
      for ele in dp {
        if Set(combi).intersection(ele).count == ele.count {
          flag = true
          break
        }
      }
      if flag == false { newCombis.append(combi)}
    }
    
    for newCombi in newCombis {
      var tempSet = Set<String>()
      for row in relation {
        tempSet.insert(newCombi.map { row[$0] }.joined())
      }
      if tempSet.count == rowCount {
        dp.insert(Set(newCombi))
      }
    }
    
    keyLength += 1
  }
  
  return dp.count
}

