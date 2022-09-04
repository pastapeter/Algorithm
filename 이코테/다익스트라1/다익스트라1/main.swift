//
//  main.swift
//  다익스트라1
//
//  Created by Jung peter on 9/4/22.
//

import Foundation

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

// 모든 간선 정보를 입력받기
for _ in 0..<m {
    let abc = readLine()!.split(separator: " ").map{ Int($0)!}
    graph[abc[0]].append((abc[1], abc[2]))
}

// 방문하지 않은 노드 중에서, 가장 최단 거리가 짧은 노드의 번호로 변환
func getSmallestNode() -> Int {
    var minValue = Int.max
    var index = 0
    // 모든 노드 중에서
    for i in 1..<n+1 {
        // 갈 수 있는 노드라면 (인접노드라면),
        // 가본적 없는 노드라면,
        if distance[i] < minValue && !visited[i] {
            minValue = distance[i]
            index = i
        }
    }
    return index
}

func dijkstra(start: Int) {
    // 시작노드에 대해 초기화
    distance[start] = 0
    visited[start] = true
    
    for j in graph[start] {
        distance[j.0] = j.1
    }
    
    // 시작노드를 제외한 모든 노드로부터 다 시도하면서 getSmallestNode()함수를 통해서 next round node를 찾는다.그게 now node
    for i in 0..<n-1 {
        // 지금까지 안들린 곳 중에 가장 가는데 안오래걸리는곳을 찾는다.
        var now = getSmallestNode()
        // 들렸다기보다는 최단 거리를 완성했다.
        visited[now] = true
        
        // 현 그래프의 인접노드로 가는 노드와 거리를 볼때
        for j in graph[now] {
            // 현 노드까지 가는 최단거리 + 거리 = cost
            var cost = distance[now] + j.1
            // 만약에 현노드까지 가는 최단 거리 + 랑 그냥 그 노드까지 가는 거리 중 지금까지 업데이트된 최단거리
            if cost < distance[j.0] {
                distance[j.0] = cost
            }
        }
    }
    
}

dijkstra(start: start)
print(distance)



