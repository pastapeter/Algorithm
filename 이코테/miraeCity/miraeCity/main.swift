//
//  main.swift
//  미래도시
//
//  Created by Jung peter on 9/5/22.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]

var graph = [[Int]](repeating: [Int](repeating: 10001, count: n + 1), count: n + 1)

for _ in 0..<m {
    let ab = readLine()!.split(separator: " ").map { Int($0)! }
    graph[ab[0]][ab[1]] = 1
    graph[ab[1]][ab[0]] = 1
}

let xk = readLine()!.split(separator: " ").map { Int($0)! }
let x = xk[0]
let k = xk[1]

for i in 1..<n+1 {
    for j in 1..<n+1 {
        if i == j {
            graph[i][j] = 0
        }
    }
}

for k in 1..<n+1 {
    for a in 1..<n+1 {
        for b in 1..<n+1 {
            graph[a][b] = min(graph[a][b], graph[a][k] + graph[k][b])
        }
    }
}

var distance = graph[1][k] + graph[k][x]

if distance >= 10001 {
    print(-1)
} else {
    print(distance)
}




