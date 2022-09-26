//
//  main.swift
//  특정도시거리찾기
//
//  Created by Jung peter on 9/26/22.
//

import Foundation

func bfs(start: Int, graph: [[Int]], dist: inout [Int]) {
  var queue: [Int] = [start]
  dist[start] = 0
  visited[start] = true
  
  while !queue.isEmpty {
    var now = queue.removeFirst()
    
    for i in graph[now] {
      if visited[i] == false {
        visited[i] = true
        dist[i] = min(dist[i], dist[now] + 1)
        queue.append(i)
      }
    }
  }
  
}

let nmkx = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nmkx[0]
let m = nmkx[1]
let k = nmkx[2]
let x = nmkx[3]

var dist = [Int](repeating: Int.max, count: n+1)
var visited = [Bool](repeating: false, count: n + 1)

var graph = [[Int]](repeating: [], count: n+1)

for _ in 0..<m {
  let input = readLine()!.split(separator: " ").map { Int(String($0))! }
  graph[input[0]].append(input[1])
}


bfs(start: x, graph: graph, dist: &dist)
var result: [Int] = []
for i in 1..<dist.count {
  if dist[i] == k {
    result.append(i)
  }
}

if result.isEmpty {
  print(-1)
} else {
  result.forEach {
    print($0)
  }
}
