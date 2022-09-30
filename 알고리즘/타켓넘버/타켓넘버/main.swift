//
//  main.swift
//  타켓넘버
//
//  Created by abc on 2021/07/01.
//

import Foundation

func solution(_ numbers:[Int], _ target:Int) -> Int {
    var answer = 0
    dfs(numbers, 0, target, 0, &answer)
    return answer
}

func dfs(_ numbers:[Int], _ index: Int, _ target: Int, _ value: Int, _ answer: inout Int){
    let n = numbers.count
    if index == n && value == target {
        answer += 1
        return
    }
    if index == n{
        return
    }
    dfs(numbers, index+1, target, value+numbers[index], &answer)
    dfs(numbers, index+1, target, value-numbers[index], &answer)
}
