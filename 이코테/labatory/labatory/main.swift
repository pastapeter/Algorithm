//
//  main.swift
//  labatory
//
//  Created by Jung peter on 9/23/22.
//

import Foundation

func bfs(start: (Int, Int), map: inout [[Int]]) {
    
    var queue: [(Int, Int)] = [start]
    
    while !queue.isEmpty {
        let now = queue.removeFirst()
        
        // 위 아래 오른쪽 왼쪽
        let dx = [0, 0, 1, -1]
        let dy = [-1, 1, 0, 0]
        
        for i in 0..<4 {
            let nx = dx[i] + now.0
            let ny = dy[i] + now.1
            
            if ny < 0 || nx < 0 || ny >= n || nx >= m {
                continue
            }
            
            if map[ny][nx] == 0 {
                map[ny][nx] = 2
                queue.append((nx, ny))
            }
        }
        
    }
}

func combi<T>(_ coor: [T], _ targetNum: Int) -> [[T]] {
    var result = [[T]]()
    
    func combination(_ index: Int, _ newCombi: [T]) {
        if newCombi.count == targetNum {
            result.append(newCombi)
            return
        }
        for i in index..<coor.count {
            combination(i+1, newCombi + [coor[i]])
        }
    }
    
    combination(0, [])
    return result
}

func solution(map: [[Int]], combi: [[(Int, Int)]]) {
    
    var results : [Int] = []
    
    for newWall in combination {
        
        var map = map
        // 벽 세우기
        for wall in newWall {
            map[wall.1][wall.0] = 1
        }
        
        // 바이러스 살포시작
        for visruse in visruses {
            bfs(start: visruse, map: &map)
        }
        
        var count = 0
        for y in 0..<n {
            for x in 0..<m {
                if map[y][x] == 0 {
                    count += 1
                }
            }
        }
     
        results.append(count)
    }

    print(results.max()!)
}

let nm = readLine()!.split(separator: " ").map { Int($0)! }

let n = nm[0]
let m = nm[1]
var map = [[Int]]()
var visruses = [(Int, Int)]()
var blackspace = [(Int, Int)]()

for _ in 0..<n {
    map.append(readLine()!.split(separator: " ").map { Int($0)! })
}

for y in 0..<n {
    for x in 0..<m {
        if map[y][x] == 2 {
            visruses.append((x, y))
        } else if map[y][x] == 0 {
            blackspace.append((x, y))
        }
    }
}




let combination = combi(blackspace, 3)
solution(map: map, combi: combination)









