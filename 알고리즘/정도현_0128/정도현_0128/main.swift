//
//  main.swift
//  정도현_0128
//
//  Created by Jung peter on 1/29/23.
//


import Foundation

func findNewBinary(num: String) -> String {
  var len = num.count
  var n = 0
  while len > 0 {
    len = len / 2
    n += 1
  }
  print(n, num, num.count)
  var supposedLen = pow(2.0, Float(n)) - 1
  var need = supposedLen - Float(num.count)
  var new = ""
  for _ in 0..<Int(need) {
    new += "0"
  }
  print(new+num)
  return new + num
}

func dfs(tree: [Int]) -> Bool {
  let start = 0
  let end = tree.count - 1
  let mid = tree.count / 2
  if mid == 0 { return true }
  if tree[mid] == 0 && (tree[mid-1] == 1 || tree[mid+1] == 1) {
    return false
  }
  var left = dfs(tree: Array(tree[start...mid-1]))
  var right = dfs(tree: Array(tree[mid+1...end]))
  return left && right
}

func solution(_ numbers:[Int64]) -> [Int] {
  
  var binaryArr: [String] = []
  var newbinArr: [String] = []
  var result: [Int] = []
  for number in numbers {
    binaryArr.append(String(number, radix: 2))
  }
  
  for bin in binaryArr {
    newbinArr.append(findNewBinary(num: bin))
  }
  
  for tree in newbinArr {
    let treeArr = tree.map{ Int(String($0))! }
    if treeArr[treeArr.count / 2] == 0 {
      result.append(0)
    }
    else {
      if dfs(tree: treeArr) == true {
        result.append(1)
      } else {
        result.append(0)
      }
    }
  }
  
  return result
}

print(solution([8]))
