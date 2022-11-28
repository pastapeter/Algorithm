//
//  main.swift
//  ps16197
//
//  Created by Jung peter on 11/25/22.
//

import Foundation

struct coor: Hashable {
    var x: Int
    var y: Int
    var dist: Int
}

struct CoorXDist: Hashable {
    var x: Int
    var y: Int
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))!}
let N = NM[0]
let M = NM[1]
let table = [".": 1, "o":2, "#": 0]
var map = [[Int]]()

for _ in 0..<N {
    map.append(readLine()!.map { table[String($0)]!})
}



func bfs(start1: coor, start2: coor) -> Int {

    var queue = [start1, start2]
    var visited1 = Set<CoorXDist>()
    
    visited1.insert(CoorXDist(x: start1.x, y: start1.y))
    var visited2 = Set<CoorXDist>()
    visited2.insert(CoorXDist(x: start2.x, y: start2.y))
    
    let dx = [1,-1,0,0]
    let dy = [0,0,1,-1]
    
    while !queue.isEmpty {
        
        var now1 = queue.removeFirst()
        var now2 = queue.removeFirst()
        if now1.dist >= 10 {return -1}
        if now2.dist >= 10 {return -1}
        
        for i in 0..<4 {
            
            let nx1 = now1.x + dx[i]
            let ny1 = now1.y + dy[i]
            
            let nx2 = now2.x + dx[i]
            let ny2 = now2.y + dy[i]
            
            
            // 둘다 떨어지기
            if (nx1 < 0 || nx1 >= M || ny1 < 0 || ny1 >= N) && (nx2 < 0 || nx2 >= M || ny2 < 0 || ny2 >= N) {
                continue
            }
            
            // nx1, ny1 만 떨어지기
            if (nx1 < 0 || nx1 >= M || ny1 < 0 || ny1 >= N) && !(nx2 < 0 || nx2 >= M || ny2 < 0 || ny2 >= N) {
                return now1.dist + 1
            }
            
            // nx2, ny2 만 떨어지기
            if !(nx1 < 0 || nx1 >= M || ny1 < 0 || ny1 >= N) && (nx2 < 0 || nx2 >= M || ny2 < 0 || ny2 >= N) {
                return now2.dist + 1
            }
            
            // 1이면 뚫려있음, 2가 시작지점, 0은 벽
            // 둘다 안떨어지기
            if (nx1 >= 0 && nx1 < M && ny1 >= 0 && ny1 < N) && (nx2 >= 0 && nx2 < M && ny2 >= 0 && ny2 < N) && !(visited1.contains(CoorXDist(x: nx1, y: ny1)) && !visited2.contains(CoorXDist(x: nx2, y: ny2))) {
                if map[ny1][nx1] == 0 && map[ny2][nx2] != 0{
                    queue.append(coor(x: now1.x, y: now1.y, dist: now1.dist + 1))
                    queue.append(coor(x: nx2, y: ny2, dist: now2.dist + 1))
                    visited2.insert(CoorXDist(x: nx2, y: ny2))
                } else if map[ny1][nx1] != 0 && map[ny2][nx2] == 0 {
                    queue.append(coor(x: nx1, y: ny1, dist: now1.dist + 1))
                    queue.append(coor(x: now2.x, y: now2.y, dist: now2.dist + 1))
                    visited1.insert(CoorXDist(x: nx1, y: ny1))
                } else if map[ny1][nx1] != 0 && map[ny2][nx2] != 0 {
                    queue.append(coor(x: nx1, y: ny1, dist: now1.dist + 1))
                    queue.append(coor(x: nx2, y: ny2, dist: now2.dist + 1))
                    visited2.insert(CoorXDist(x: nx2, y: ny2))
                    visited1.insert(CoorXDist(x: nx1, y: ny1))
                } else {
                    continue
                }
            }
        }
    }
    
   return -1
}


func solution() {
    var coins: [coor] = []
    for y in 0..<N {
        for x in 0..<M {
            if map[y][x] == 2 {
                coins.append(coor(x: x, y: y, dist: 0))
            }
        }
    }
    print(bfs(start1: coins[0], start2: coins[1]))
}

solution()
