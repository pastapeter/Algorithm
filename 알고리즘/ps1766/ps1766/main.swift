//
//  main.swift
//  ps1766
//
//  Created by Jung peter on 4/2/23.
//

import Foundation

/*
 1번풀이: 위상정렬 + queue 내부 정렬?
 이거로는 시간복잡도가 O(N*M)일 것 같았음
 무조건 1억은 안되겠다 싶었음
 그래서 했더니 되었다.
 
 4 - 2
 3 - 1
 이 있을 때
 시작지점을 둘다 큐에 넣는다 [4,3]
 큐를 정렬한다. [3,4]
 하나 빼고 위상정렬 한번 실시! [4, 1]
 다시 큐를 정렬 [1,4]
 하나 뺴고 위상정렬 실시 [4]
 다시 큐를 정렬 [4]
 하나 뺴고 위상정렬 실시 [2]
 ... 
 */

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]
var graph: [Int: [Int]] = [:]
for i in 1...n {
  graph.updateValue([], forKey: i)
}
var indegree = [Int](repeating: 0, count: n+1)
for _ in 0..<m {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  // a는 b보다 무조건 먼저 풀어야한다.
  let a = temp[0]
  let b = temp[1]
  graph[b]!.append(a)
  graph[a]!.append(b)
  indegree[b] += 1
}

var ans = ""
var queue: [Int] = []
for i in 1...n {
  if indegree[i] == 0 {
    queue.append(i)
  }
}

while !queue.isEmpty {
  queue.sort(by: <)
  let poped = queue.removeFirst()
  ans += "\(poped) "
  
  for i in graph[poped]! {
    indegree[i] -= 1
    if indegree[i] == 0 {
      queue.append(i)
    }
  }
  
}

print(ans)




