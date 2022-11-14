//
//  main.swift
//  candy game
//
//  Created by Jung peter on 11/14/22.
//

import Foundation

func swap(at lhs: (x: Int, y: Int), at rhs: (x: Int, y:Int)) {
    let temp = map[lhs.y][lhs.x]
    map[lhs.y][lhs.x] = map[rhs.y][rhs.x]
    map[rhs.y][rhs.x] = temp
}

func isContinue(arr: [String]) -> Int {
    var split = arr[0]
    var maxInt = Int.min
    var count = 0
    for i in arr {
        if i == split {
            count += 1}
        else {
            maxInt = max(count, maxInt)
            split = i
            count = 1
        }
    }
    maxInt = max(count, maxInt)
    return maxInt
}

let input = Int(readLine()!)!
var map = [[String]]()
for _ in 0..<input {
    let colors = readLine()!.map { String($0)}
    map.append(colors)
}

let dx = [-1, 1, 0, 0]
let dy = [0, 0, 1, -1]

func solution() -> Int {
    var maxInt = 1
    for y in 0..<input {
        for x in 0..<input {
            
            for i in 0..<4 {
                let nx = x + dx[i]
                let ny = y + dy[i]
                
                if nx < 0 || ny < 0 || nx >= input || ny >= input {continue}
                
                if map[y][x] == map[ny][nx] { continue }
                
                swap(at: (x: x, y:y), at: (x: nx, y: ny))
                
                for k in 0..<input {
                    
                    maxInt = max(isContinue(arr: map[k]), maxInt)
        
                    var column: [String] = []
                    for j in 0..<input {
                        column += [map[j][k]]
                    }
                    maxInt = max(isContinue(arr: column), maxInt)
                    
                    if maxInt == input {return maxInt}
                }
                
                swap(at: (x: x, y:y), at: (x: nx, y: ny))
            }
        }
        
    }
    return maxInt
}

print(solution())
