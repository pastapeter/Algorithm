//
//  main.swift
//  다익스트라2
//
//  Created by Jung peter on 9/4/22.
//

import Foundation

struct EdgeAndNode: Comparable{
    static func < (lhs: EdgeAndNode, rhs: EdgeAndNode) -> Bool {
        return lhs.dist < rhs.dist
    }
    
    init(_ dist: Int, _ node: Int) {
        self.dist = dist
        self.node = node
    }
    let dist: Int
    let node: Int
}

let nm = readLine()!.split(separator: " ").map{ Int($0)!}
let n = nm[0]
let m = nm[1]
let start = Int(readLine()!)!

// 각 노드에 연결되어있는 노드에 대한 정보를 담는 리스트 만들기
var graph = [[(Int, Int)]](repeating: [], count: n + 1)

// 방문한 적이 있는지 체크하는 목적의 리스트 만들기
var visited = [Bool](repeating: false, count: n + 1)

// 최단거리 테이블을 모두 무한으로 초기화
var distance = [Int](repeating: Int.max, count: n + 1)

for _ in 0..<m {
    let abc = readLine()!.split(separator: " ").map{ Int($0)!}
    // node dost
    //
    graph[abc[0]].append((abc[1], abc[2]))
}

func dijkstra(start:Int) {
    var q: [EdgeAndNode] = [EdgeAndNode(0, start)]
    // 시작노드로 가기 위한 최단 경로는 0으로 설정, 큐에 삽입
    var heapq = PriorityQueue(ascending: true, startingValues: q)
    distance[start] = 0
    while !heapq.isEmpty {
        guard let distNow = heapq.pop() else {break}
        var dist = distNow.dist
        var now = distNow.node
        
        if distance[now] < dist {
            continue
        }
        
        for i in graph[now] {
            var cost = dist + i.1
            if cost < distance[i.0] {
                distance[i.0] = cost
                heapq.push(EdgeAndNode(cost, i.0))
            }
        }
    }
    
}


dijkstra(start: start)

for i in 1..<n+1 {
    if distance[i] == Int.max {
        print("INF")
    } else {
        print(distance[i])
    }
}
