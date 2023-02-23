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
var L = [Int](repeating: Int.max, count: 10001)
var graph = [[Int]](repeating: [], count: v+1)
var res = [Bool](repeating: false, count: 10001)
for _ in 0..<e {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  graph[temp[0]].append(temp[1])
  graph[temp[1]].append(temp[0])
}

// 무방향 그래프에서 DFS 스패닝트리를 돌리기 위해서는
// 정점의 방문 순서를 먼저 파악해야한다.
// 방문 순서를 파악해야만 cycle을 확인할 수 있기 때문
// 부모를 제외한 정점들은 이미 방문했다고 판단되면 마지막이 되는 것!
var finished = [Int](repeating: 0, count: 10001)
func dfsSpanningTree(node: Int) {
  cnt += 1
  discovered[node] = cnt
  for next in graph[node] {
    
    if discovered[next] == 0 {
      dfsSpanningTree(node: next)
      // next 방문을 했지만
    } else if discovered[next] < discovered[node] {
      // 이건 괜찮음
      print("순방향 간선 \(next) - \(node)")
      // 앞에 간선
    } else if finished[next] == 0 {
      print("끝남요 \(next) - \(node)")
    } else {
      print("교차간선 \(next) - \(node) ")
    }
    
  }
  finished[node] = 1
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
    if discovered[next] == 0 { //그래프중에 방문안한 것이 있다면?
      
      child += 1 // 자식몇개인지 찾기
      
      let low = dfs(now: next, root: false) //
      //
      num = min(low, num)
      if (!root && low >= discovered[now]) { res[now] = true }
    } else { // 이미 방문하였다면? 현재의 방문순서, 자식의 방문순서 확인
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
print("")
print(discovered[1...v])
print(L[1...v])


extension Array<String> {
  
}



