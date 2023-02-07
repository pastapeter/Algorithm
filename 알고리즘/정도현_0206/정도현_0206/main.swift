//
//  main.swift
//  정도현_0206
//
//  Created by Jung peter on 2/7/23.
//

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = NK[0]
let k = NK[1]

var s = readLine()!.split(separator: " ").map { Int(String($0))!}

var start = 0
var end = -1
var oddcnt = 0
var result = 0

while end < n-1 {
  end += 1
  if !s[end].isMultiple(of: 2) {
    oddcnt += 1
  }
  
  if oddcnt <= k {
    result = max(result, end-start+1 - oddcnt)
  } else if oddcnt > k {
    if !s[start].isMultiple(of: 2) {
      start += 1
      oddcnt -= 1
    } else {
      start += 1
    }
  }
  
}

print(result)
