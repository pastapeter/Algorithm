//
//  main.swift
//  topology sort
//
//  Created by Jung peter on 9/6/22.
//

import Foundation

let ve = readLine()!.split(separator: " ").map { Int($0)!}
let v = ve[0]
let e = ve[1]

var indegree = [Int](repeating: 0, count: v + 1)
var graph = [[Int]](repeating: [], count: v+1)


for _ in 0..<e {
    let ab = readLine()!.split(separator: " ").map { Int($0)! }
    let a = ab[0]
    let b = ab[1]
    graph[a].append(b)
    indegree[b] += 1
}

func topologySort() {
    var result: [Int] = []
    var q = [Int]()
    // 진입차수가 0인것을 먼저 시작으로,  q에 삽입
    for i in 1..<v+1 {
        if indegree[i] == 0 {
            q.append(i)
        }
    }
    
    while !q.isEmpty {
        // 큐에서 맨앞에 빼기
        var now = q.removeFirst()
        result.append(now)
        
        //현재 vertex와 연결된 vertex의 진입차수를 1씩 뺀다
        for i in graph[now] {
            indegree[i] -= 1
            
            //그리고 그때 0 인경우를 큐에 다시 넣는다.
            if indegree[i] == 0 {
                q.append(i)
            }
        }
    }
    print(result)
}

topologySort()


