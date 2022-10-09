//
//  main.swift
//  볼링공고르기2차시도
//
//  Created by Jung peter on 10/5/22.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
var balls = readLine()!.split(separator: " ").map { Int(String($0))!}

let n = nm[0]
let m = nm[1]
var result = 0

balls.sort()

for i in balls.indices {
    for j in i..<balls.count {
        if balls[i] + balls[j] <= m {
            result += 1
        } else {
            break
        }
    }
}


