//
//  main.swift
//  11657 타임머신
//
//  Created by abc on 2022/02/13.
//

import Foundation

let input = readLine()!.split(separator: " ").map {Int(String($0))!}
let INF = Int.max
let N = input[0]
let M = input[1]
var edgeList: [(A: Int, B: Int, C: Int)] = []

for _ in 0..<M {
  let bus = readLine()!.split(separator: " ").map{Int(String($0))!}
  edgeList.append((A: bus[0], B: bus[1], C: bus[2]))
}


var dist = [Int](repeating: INF, count: N + 1)

func bellmanFord(_ start: Int) -> Bool {
  dist[start] = 0
  for i in 0..<N {
    // N-1 번을 실행하는 이유는 shortestpath의 max가 N-1 모든 경우를 찾는것
    for j in 0..<edgeList.count {
      // 모든 간선을 체크한다.
      let current = edgeList[j].0
      let next = edgeList[j].1
      let weight = edgeList[j].2
      if dist[current] != INF && dist[current] + weight < dist[next] {
        dist[next] = dist[current] + weight
        if i == N - 1 {
          return true
        }
      }
    }
  }
  return false
}

if bellmanFord(1) == true {
  print(-1)
} else {
  for i in 2..<dist.count {
    if dist[i] == INF {
      print(-1)
    } else {
      print(dist[i])
    }
  }
}


