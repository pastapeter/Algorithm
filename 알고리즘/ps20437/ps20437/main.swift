//
//  main.swift
//  ps20437
//
//  Created by Jung peter on 2/26/23.
//

import Foundation

let T = Int(readLine()!)!
for _ in 0..<T {
  
  var dic2: [String: [Int]] = ["a":[], "b":[], "c":[], "d":[], "e":[], "f":[],
             "g":[], "h":[], "i":[], "j":[], "k":[], "l":[],
             "m":[], "n":[], "o":[], "p":[], "q":[], "r":[],
             "s":[], "t":[], "u":[], "v":[], "w":[], "x":[],
             "y":[], "z":[]]
  
  let str = readLine()!.map { String($0) }
  let k = Int(readLine()!)!

  var maxIdx = 0
  var minIdx = Int.max

  str.enumerated().forEach {
    dic2[$0.element]!.append($0.offset)
  }

  // 알파벳중에서 k보다 많이 나온 경우
  let candidates = dic2.filter { $0.value.count >= k }
  if candidates.count == 0 {
    print(-1)
    continue
  }
  // 해당 알파벳을 돌면서
  for candidate in candidates {
    // 각 배열을 도는데, 최악의 경우 모든 배열에 w가 다 들어가서 모두 도는 경우
    // 그럴때 그냥 w를 다 순회하니깐 w임
    for start in 0..<(candidate.value.count)-k+1 {
      let temp = abs(candidate.value[start+k-1] - candidate.value[start]) + 1
       maxIdx = max(maxIdx, temp)
       minIdx = min(minIdx, temp)
    }
  }
  print("\(minIdx) \(maxIdx)")
}

