//
//  main.swift
//  경쟁적전염
//
//  Created by Jung peter on 9/26/22.
//

import Foundation

func bfs(start: [(Int, Int, Int, Int)], map: inout [[Int]]) {
    var queue = start
    
    while !queue.isEmpty {
        
        let now = queue.removeFirst()
        
        if now.2 == s {
            break
        }
        
        let dx = [-1, 1, 0, 0]
        let dy = [0, 0, -1, 1]
        
        for i in 0..<4 {
            
            let nx = dx[i] + now.0
            let ny = dy[i] + now.1
            
            if nx < 0 || ny < 0 || nx >= n || ny >= n {
                continue
            }
            
            // 안들린 곳만
            if map[ny][nx] == 0 {
                map[ny][nx] = now.3
                queue.append((nx, ny, now.2 + 1, now.3))
            }
        }
        
    }
    
}

let nk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nk[0]
let k = nk[1]
var map = [[Int]](repeating: [], count: n)

// map input
for y in 0..<n {
    map[y] += readLine()!.split(separator: " ").map { Int($0)! }
}

//sxy
let sxy = readLine()!.split(separator: " ").map { Int($0)! }
let s = sxy[0]
let x = sxy[1] - 1
let y = sxy[2] - 1

var first: [(Int, Int, Int, Int)] = []

for y in map.indices {
    for x in map.indices {
        if map[y][x] != 0 {
            first.append((x, y, 0, map[y][x]))
        }
    }
}

first.sort(by: { $0.3 < $1.3 })
bfs(start: first, map: &map)


print(map[x][y])
