//
//  main.swift
//  볼링공고르기
//
//  Created by Jung peter on 9/10/22.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)!}
let n = nm[0]
let m = nm[1]
let balls = readLine()!.split(separator: " ").map { Int($0)!}
var result = [(Int, Int)]()


for i in balls.indices {
    let ball = balls[i]
    for j in i+1..<balls.count {
        if balls[j] == ball {
            continue
        }
        result.append((ball, balls[j]))
    }
}

print(result.count)

