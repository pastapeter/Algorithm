//
//  main.swift
//  ps2667
//
//  Created by Jung peter on 11/24/22.
//

import Foundation

let N = Int(readLine()!)!
var map = [[Int]]()
var dong = 0

for i in 0..<N {
    map.append(readLine()!.map { Int(String($0))!})
}

func bfs(start: (x: Int, y: Int)) -> Int {
    
    let dx = [1, -1, 0, 0]
    let dy = [0, 0, 1, -1]
    var cnt = 0
    
    var queue = [start]
    // visited
    map[start.y][start.x] = 0
    
    while !queue.isEmpty {
        
        let now = queue.removeFirst()
        cnt += 1
        
        for i in 0..<4 {
            let nx = now.x + dx[i]
            let ny = now.y + dy[i]
            
            if nx < 0 || ny < 0 || nx >= N || ny >= N {
                continue
            }
            
            if map[ny][nx] != 0 {
                queue.append((x: nx, y: ny))
                map[ny][nx] = 0
            }
            
        }
        
        
    }
    
    return cnt
}

func solution() {
    var answer: [Int] = []
    for y in 0..<N {
        for x in 0..<N {
            if map[y][x] != 0 {
                var res = bfs(start: (x: x, y: y))
                answer.append(res)
                dong += 1
            }
        }
    }
    
    print(dong)
    answer.sorted().forEach {
        print($0)
    }
}

solution()
