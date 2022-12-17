//
//  main.swift
//  회전초밥
//
//  Created by Jung peter on 12/17/22.
//

import Foundation

let Ndkc = readLine()!.split(separator: " ").map {Int(String($0))!}
let N = Ndkc[0]
let d = Ndkc[1]
let k = Ndkc[2]
let c = Ndkc[3]

var sushis: [Int] = []
var duplicate: Set<Set<Int>> = []

for i in 0..<N {
  sushis.append(Int(readLine()!)!)
}

func solution() {
  var start = 0
  var end = k

  // 7 9 7 30 2 7 9 25
  var temp: Set<Int> = Set(sushis[start..<end])
  var result = 0
  while start < sushis.count && end < sushis.count {
    if end - start < k {
      temp.insert(sushis[end])
      end += 1
    } else if end - start > k {
      start += 1
    }
    if end - start == k {
      temp = Set(sushis[start..<end] + [c])
      duplicate.insert(temp)
      result = max(result, temp.count)
      start += 1
    }
  }
  print(result)
}


func solution2() {
  var start = 0
  var end = k-1
  var result = 1
  var dic: [Int: Int] = [c:1]
  for j in start...end {
    if dic[sushis[j%N]] == nil {
      dic[sushis[j%N]] = 1
    } else {
      dic[sushis[j%N]]! += 1
    }
  }
  
  result = max(dic.count, result)
  for _ in 0..<N {
    dic[sushis[start]]! -= 1
    if dic[sushis[start]] == 0 {
      dic[sushis[start]] = nil
    }
    
    start = (start+1)%N
    end = (end+1)%N
    
    if dic[sushis[end]] == nil {
      dic[sushis[end]] = 1
    } else {
      dic[sushis[end]]! += 1
    }
    
    result = max(dic.count, result)
    if dic.count >= k+1 {
      break
    }
    
  }
  print(result)
}
solution()
