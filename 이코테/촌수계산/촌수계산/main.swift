//
//  main.swift
//  촌수계산
//
//  Created by Jung peter on 10/29/22.
//

import Foundation

let n = Int(readLine()!)!
let players = readLine()!.split(separator: " ").map { Int(String($0))!}

let player1 = players[0]
let player2 = players[1]
var graph : [Int: [Int]] = [:]
var visited = [Int](repeating: 0, count: n+1)
for i in 1..<n+1 {
    graph.updateValue([], forKey: i)
}

let m = Int(readLine()!)!
for _ in 0..<m {
    let ab = readLine()!.split(separator: " ").map { Int(String($0))! }
    graph[ab[0]]!.append(ab[1])
    graph[ab[1]]!.append(ab[0])
}

func dfs(start: Int) {

    for ele in graph[start]! {
        if start != ele && visited[ele] == 0 {
            visited[ele] = visited[start] + 1
            dfs(start: ele)
        }
    }
}
dfs(start: player1)
if visited[player2] == 0 {
    print(-1)
} else {
    print(visited[player2])
}
