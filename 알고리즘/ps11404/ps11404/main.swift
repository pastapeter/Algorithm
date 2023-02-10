//
//  main.swift
//  ps11404
//
//  Created by Jung peter on 2/10/23.
//

import Foundation

// 모든 도시의 쌍(A,B)에 대해 도시 A, B로 가는 최소값을 구하는 것 -> 플로이드워샬

// 하나의 도시에서 각 도시로의 최소값을 구하는 것 -> 다익스트라

let n = Int(readLine()!)!
let m = Int(readLine()!)!
var graph = [[Int]](repeating: [Int](repeating: Int.max, count: n+1), count: n+1)

for y in 1..<n+1 {
  graph[y][y] = 0
}

for i in 0..<m {
  let abc = readLine()!.split(separator: " ").map { Int(String($0))!}
  let a = abc[0]
  let b = abc[1]
  let c = abc[2]
  graph[a][b] = min(graph[a][b], c)
}

// 플로이드 워샬
for k in 1..<n+1 {
  for y in 1..<n+1 {
    for x in 1..<n+1 {
      if graph[y][k] == Int.max || graph[k][x] == Int.max {
        graph[y][x] = graph[y][x]
      } else {
        graph[y][x] = min(graph[y][x], graph[y][k] + graph[k][x])
      }
    }
  }
}

for y in 1..<n+1 {
  for x in 1..<n+1 {
    if graph[y][x] == Int.max {
      print(0, terminator: " ")
    } else {
      print(graph[y][x], terminator: " ")
    }
  }
  print("")
}
