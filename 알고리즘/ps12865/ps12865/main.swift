//
//  main.swift
//  ps12865
//
//  Created by Jung peter on 3/25/23.
//

import Foundation

/*
 이 문제는 아주 평범한 배낭에 관한 문제이다.

 한 달 후면 국가의 부름을 받게 되는 준서는 여행을 가려고 한다. 세상과의 단절을 슬퍼하며 최대한 즐기기 위한 여행이기 때문에, 가지고 다닐 배낭 또한 최대한 가치 있게 싸려고 한다.

 준서가 여행에 필요하다고 생각하는 N개의 물건이 있다. 각 물건은 무게 W와 가치 V를 가지는데, 해당 물건을 배낭에 넣어서 가면 준서가 V만큼 즐길 수 있다. 아직 행군을 해본 적이 없는 준서는 최대 K만큼의 무게만을 넣을 수 있는 배낭만 들고 다닐 수 있다. 준서가 최대한 즐거운 여행을 하기 위해 배낭에 넣을 수 있는 물건들의 가치의 최댓값을 알려주자.
 */

/*
 Knapsack문제이다.
 dp에서 가방에 현재 물건을 담을 수 있는지의 여부가 중요하다
 담을 수 있다면, 담기전의 최대값 vs 담은 뒤의 값(담기 전 중 해당 무게를 남겼을떄의 최대값 + 현재 물건의 가치)
 */

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




