//
//  main.swift
//  음료수얼려먹기
//
//  Created by Jung peter on 8/19/22.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]

var map = [[Int]](repeating: [], count: n)
var result = 0

for i in 0..<n {
    map[i] += readLine()!.map { Int(String($0))!}
}

func dfs(x: Int, y: Int) -> Bool {
    
    if x < 0 || y < 0 || y >= n || x >= m {
        return false
    }
    
    if map[y][x] == 0 {
        map[y][x] = 1
        dfs(x: x-1, y: y)
        dfs(x: x+1, y: y)
        dfs(x: x, y: y-1)
        dfs(x: x, y: y+1)
        return true
    }
    return false
    
}

for y in 0..<n {
    for x in 0..<m {
        if dfs(x: x, y: y) {
            result += 1
        }
    }
}

print(result)
