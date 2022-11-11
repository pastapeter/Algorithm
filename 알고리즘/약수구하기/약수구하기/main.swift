//
//  main.swift
//  약수구하기
//
//  Created by Jung peter on 11/7/22.
//

import Foundation

let input = readLine()!.split(separator: " ").map { Int(String($0))!}

func solution(n: Int, k: Int) -> Int {
    var answers: [Int] = []
    for i in (1...n) {
        if n % i == 0{
            answers += [i]
        }
    }
    
    if answers.count < k {
        return 0
    }
    
    return answers[k-1]
}

print(solution(n: input[0], k: input[1]))



