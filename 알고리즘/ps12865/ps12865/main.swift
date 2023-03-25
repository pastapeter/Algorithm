//
//  main.swift
//  ps12865
//
//  Created by Jung peter on 3/25/23.
//

import Foundation

let nk = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nk[0]
let k = nk[1]
var wv: [(w: Int, v: Int)] = [(w: 0, v: 0)]
var dp = [[Int]](repeating: [Int](repeating: 0, count: k+1), count: n+1)

for _ in 0..<n {
  let tmp = readLine()!.split(separator: " ").map { Int(String($0))!}
  wv.append((w: tmp[0], v: tmp[1]))
}

wv.sort(by: { $0.w < $1.w})

for y in 1...n {
  for x in 1...k {
    // 해당 물품 넣을 수 있음
    if wv[y].w <= x {
      dp[y][x] = max(dp[y-1][x], dp[y-1][x-wv[y].w] + wv[y].v)
    } else {
      dp[y][x] = dp[y-1][x]
    }
  }
}

print(dp[n][k])




