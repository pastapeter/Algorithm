//
//  main.swift
//  인구이동
//
//  Created by Jung peter on 10/9/22.
//

import Foundation

//국경선을 공유하는 두 나라의 인구차이 L 이상 R 이하, 국경선을 하루동안 연당
// 국경선이 모두 열리면 인구이동
// 인접한 칸만 이용해 이동가능, 오늘 하루동안 연합이다.
// 연합을 이루는 각 칸의 인구수는 나누기

let nlr = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nlr[0]
let l = nlr[1]
let r = nlr[2]
var map = [[Int]]()
var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
var aliance = [[(x: Int, y: Int)]]()
var count = 0
var sx = 0
var sy = 0

for _ in 0..<n {
    map.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

//느낌상 bfs인데, dx, dy를 적절히 바꿔주면서

func checkPopulation(from: (x: Int, y: Int), to: (x: Int, y: Int)) -> Bool {
    if abs(map[from.y][from.x] - map[to.y][to.x]) >= l && abs(map[from.y][from.x] - map[to.y][to.x]) <= r {
        return true
    }
    
    return false
}

func bfs(start: (x: Int, y: Int)) {
    
    var queue = [start]
    var index = 0
    visited[start.y][start.x] = true

    while index < queue.count {

        let now = queue[index]
        index += 1
        
        let dx = [1, -1, 0, 0]
        let dy = [0, 0, 1, -1]
        
        for i in 0..<4 {
            
            let nx = now.x + dx[i]
            let ny = now.y + dy[i]

            if nx < 0 || ny < 0 || nx >= n || ny >= n || visited[ny][nx] == true {
                continue
            }
            
            if checkPopulation(from: now, to: (x: nx, y: ny)){
                queue.append((x: nx, y: ny))
                visited[ny][nx] = true
            }
        }
    }
    aliance.append(queue)
}

func solution() -> Int {
    
    while true {
        aliance = [[(x: Int, y: Int)]]()
        visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
        for y in 0..<n {
            for x in 0..<n {
                if visited[y][x] == false {
                    bfs(start: (x: x, y: y))
                }
            }
        }
        
        if aliance.count == n * n {
            break
        }
        
        for i in 0..<aliance.count {
            var sum = 0
            if aliance[i].count == 1 {
                continue
            }
            aliance[i].forEach {
                sum += map[$0.y][$0.x]
            }
            aliance[i].forEach {
                map[$0.y][$0.x] = sum / aliance[i].count
            }
        }
        count += 1
        
    }
    
    return count
}


print(solution())
