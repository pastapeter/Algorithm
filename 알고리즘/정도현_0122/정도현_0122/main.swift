//
//  main.swift
//  정도현_0122
//
//  Created by Jung peter on 1/23/23.
//

import Foundation

let nk = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nk[0]
let k = nk[1]
var dp = [[Int]](repeating: [Int](repeating: 0, count: k+1), count: k+1)
var wvs: [(w: Int, v: Int)] = [(0,0)]

for _ in 1...n {
  let wv = readLine()!.split(separator: " ").map { Int(String($0))!}
  let w = wv[0]
  let v = wv[1]
  wvs.append((w, v))
}

for y in 1..<wvs.count {
  for x in 1...k {
    if x < wvs[y].w { dp[y][x] =  dp[y-1][x]}
    else {
      dp[y][x] = max(dp[y-1][x], dp[y-1][x-wvs[y].w] + wvs[y].v)
    }
  }
}

print(dp[n][k])


