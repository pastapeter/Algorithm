//
//  main.swift
//  ps11266
//
//  Created by Jung peter on 2/19/23.
//

import Foundation

let ve = readLine()!.split(separator: " ").map { Int(String($0))! }
let v = ve[0]
let e = ve[1]
var cnt: Int = 0
var discovered = [Int](repeating: 0, count: 10001)
var graph = [[Int]](repeating: [], count: v+1)
var res = [Bool](repeating: false, count: 10001)
for _ in 0..<e {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  graph[temp[0]].append(temp[1])
  graph[temp[1]].append(temp[0])
}

func dfs(now: Int, root: Bool) -> Int {
  cnt += 1
  discovered[now] = cnt
  // 일단 discover order를 찾아
  var num = discovered[now]
  // 현재 discover order의 값인데,
  // L(child) >= D[parent] 확인해야함
  var child = 0
  for next in graph[now] {
    if discovered[next] == 0 {
      child += 1
      let low = dfs(now: next, root: false)
      num = min(low, num)
      if (!root && low >= discovered[now]) { res[now] = true }
    } else {
      num = min(num, discovered[next])
    }
  }
  if root && child > 1 {
    res[now] = true
  }
  return num
}

for i in 1...v {
  if discovered[i] == 0 {
    dfs(now: i, root: true)
  }
}
var result = 0
for i in 1...v {
  if res[i] == true { result += 1}
}
print(result)
for i in 1...v {
  if res[i] == true { print(i, terminator: " ")}
}

