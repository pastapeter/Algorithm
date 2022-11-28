//
//  main.swift
//  ps16916
//
//  Created by Jung peter on 11/24/22.
//

import Foundation

let s = readLine()!
let p = readLine()!
var pArr = p.map { String($0) }
let sArr = s.map { String($0) }
var pi = [Int](repeating: 0, count: p.count)

func pattern(p: [String]) {
    var j = 0
    for i in 1..<p.count {
        while j>0 && p[i] != p[j] {
            j = pi[j-1]
        }
        if p[i] == p[j] {
            j += 1
            pi[i] = j
        }
    }
}

func solution() -> Int {
    pattern(p: pArr)
    var j = 0
    for i in sArr.indices {
        while j > 0 && (sArr[i] != pArr[j]) {
            j = pi[j-1]
        }
        if sArr[i] == pArr[j] {
            if j == pArr.count - 1{
                return 1
            } else {
                j += 1
            }
        }
    }
    return 0
}

print(solution())

