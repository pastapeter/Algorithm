//
//  main.swift
//  정도현_0210
//
//  Created by Jung peter on 2/10/23.
//

import Foundation

let ndkc = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = ndkc[0]
let d = ndkc[1]
let k = ndkc[2]
let c = ndkc[3]

var sushis = [Int]()

for _ in 0..<n {
  sushis.append(Int(readLine()!)!)
}

var dic = [c: 1]
var maxInt = Int.min

for i in 0..<n+k-1 {

  if dic[sushis[i%n]] == nil {
    dic.updateValue(1, forKey: sushis[i%n])
  } else {
    dic.updateValue(dic[sushis[i%n]]! + 1, forKey: sushis[i%n])
  }
  
  if i >= k {
    dic.updateValue(dic[sushis[(i-k)%n]]! - 1, forKey: sushis[(i-k)%n])
    if dic[sushis[(i-k)%n]]! == 0 {
      dic.removeValue(forKey: sushis[(i-k)%n])
    }
  }
  
  maxInt = max(maxInt, dic.count)
  
}

print(maxInt)
