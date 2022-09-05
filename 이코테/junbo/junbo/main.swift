//
//  main.swift
//  junbo
//
//  Created by Jung peter on 9/5/22.
//

import Foundation

struct EdgeNode:Comparable {
    static func < (lhs: EdgeNode, rhs: EdgeNode) -> Bool {
        return lhs.dist > rhs.dist
    }
    
    let dist: Int
    let node: Int
}

let nmc = readLine()!.split(separator: " ").map { Int($0)! }
let n =  nmc[0] // 도시의 갯수
let m = nmc[1] // 통로의 개수
let c = nmc[2] // 메세지를 보내고자 하는 도시

var graph = [[(Int, Int)]](repeating: [], count: n + 1)

var distance = [Int](repeating: Int.max, count: n + 1)

for _ in 0..<m {
    let xyz = readLine()!.split(separator: " ").map { Int($0)! }
    graph[xyz[0]].append((xyz[1], xyz[2]))
}

func dijkstra(start: Int) {
    
    var heapq = PriorityQueue(ascending: true, startingValues: [EdgeNode(dist: 0, node: start)])
    distance[start] = 0
    
    while !heapq.isEmpty {
        guard let distNow = heapq.pop() else {break}
        
        let dist = distNow.dist
        let now = distNow.node
        
        if distance[now] < dist {
            continue
        }
        
        for i in graph[now] {
            var cost = dist + i.1
            if cost < distance[i.0] {
                distance[i.0] = cost
                heapq.push(EdgeNode(dist: cost, node: i.0))
            }
        }
    }

}

dijkstra(start: c)

distance = distance.filter {
    $0 > 0 && $0 < Int.max
}

print(distance.count, distance.max() ?? 0)
