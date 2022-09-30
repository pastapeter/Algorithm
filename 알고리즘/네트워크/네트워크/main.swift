//
//  main.swift
//  네트워크
//
//  Created by abc on 2021/07/01.
//

import Foundation

func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    var answer = 0
    var visited = [Bool](repeating: false, count: n)
    for i in 0..<n{
        if visited[i] == false {
            dfs(computers, &visited, i)
            answer += 1
        }
    }
    return answer
}

func dfs(_ computers: [[Int]], _ visited: inout [Bool], _ start: Int){
    visited[start] = true
    for i in 0..<computers[start].count{
        if visited[i] == false && computers[start][i] == 1{
            dfs(computers, &visited, i)
        }
    }
}
let n = 6
let input = [[1, 0, 1, 1, 0, 0], [0, 1, 0, 0, 1, 1], [1, 0, 1, 1, 1, 1], [1, 0, 1, 1, 1, 1], [0, 1, 1, 1, 1, 1], [0, 1, 1, 1, 1, 1]]
print(solution(n, input))
