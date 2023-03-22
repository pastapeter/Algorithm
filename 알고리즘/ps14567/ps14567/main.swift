//
//  main.swift
//  ps14567
//
//  Created by Jung peter on 3/22/23.
//
/*
 올해 Z대학 컴퓨터공학부에 새로 입학한 민욱이는 학부에 개설된 모든 전공과목을 듣고 졸업하려는 원대한 목표를 세웠다. 어떤 과목들은 선수과목이 있어 해당되는 모든 과목을 먼저 이수해야만 해당 과목을 이수할 수 있게 되어 있다. 공학인증을 포기할 수 없는 불쌍한 민욱이는 선수과목 조건을 반드시 지켜야만 한다. 민욱이는 선수과목 조건을 지킬 경우 각각의 전공과목을 언제 이수할 수 있는지 궁금해졌다. 계산을 편리하게 하기 위해 아래와 같이 조건을 간소화하여 계산하기로 하였다.

 한 학기에 들을 수 있는 과목 수에는 제한이 없다.
 모든 과목은 매 학기 항상 개설된다.
 모든 과목에 대해 각 과목을 이수하려면 최소 몇 학기가 걸리는지 계산하는 프로그램을 작성하여라.
 */

/*
 문제풀이
 오랜만에 푸는 위상정렬이다. 근데 신기하게도, 난 다 까먹은줄알았는데, 금방풀었다?
 선수과목을 들을 수 있는 조건은 indegree가 다 사라지면 들을 수 있다.
 indgree가 0인 노드부터 queue에 넣으면서 시작한다. 그리고 indegree가 0인 과목등은 1학기에 들을 수 있는것이다.
 그리고 선수과목들이 있는 과목들은 언제들을 수 있냐면, 이것도 indegree가 0이 되어야한다. 그리고 이때, 해당 과목을 언제 들을 수 있는지는, 가장 마지막으로 사라지는 선수과목을 들을 수 있는 학기+1 이다.
 */

import Foundation

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]
var graph = [[Int]](repeating: [], count: n+1)
var indegree = [Int](repeating: 0, count: n+1)
for _ in 0..<m {
  let ab = readLine()!.split(separator: " ").map { Int(String($0))!}
  let a = ab[0]
  let b = ab[1]
  graph[a].append(b)
  indegree[b] += 1
}


func solve() -> String {
  var ans = [Int](repeating: 0, count: n+1)
  var queue: [Int] = []
  var cnt = 1
  for i in 1...n {
    if indegree[i] == 0 {
      queue.append(i)
      ans[i] = cnt
    }
  }
  while !queue.isEmpty {
    let poped = queue.removeFirst()
    for node in graph[poped] {
      indegree[node] -= 1
      if indegree[node] == 0 {
        queue.append(node)
        ans[node] = ans[poped]+1
      }
    }
  }
  return ans[1...].map { String($0) }.joined(separator: " ")
}

print(solve())



