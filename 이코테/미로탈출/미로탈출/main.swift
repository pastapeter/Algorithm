//
//  main.swift
//  미로탈출
//
//  Created by Jung peter on 8/19/22.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]
var map = [[Int]](repeating: [], count: n)
var visited = [[Int]](repeating: [Int](repeating: 0, count: m), count: n)
var queue: [(Int, Int)] = [(0, 0)]

var count = 1

for i in 0..<n {
    map[i] += readLine()!.map {Int(String($0))!}
}

func bfs() {
    visited[0][0] = 1
    while !queue.isEmpty {
        let start = queue.removeFirst()
        
        let dx = [1, -1, 0, 0]
        let dy = [0, 0, -1, 1]
        
        for i in dy.indices {
            let ny = start.1 + dy[i]
            let nx = start.0 + dx[i]
            
            if nx < 0 || ny < 0 || ny >= n || nx >= m {
                continue
            }
            
            if map[ny][nx] == 0 {
                continue
            }
            
            if map[ny][nx] == 1 && visited[ny][nx] == 0{
                visited[ny][nx] = visited[start.1][start.0] + 1
                queue.append((nx, ny))
            }
        }
        
    }
    print(visited[n-1][m-1])
}

bfs()



