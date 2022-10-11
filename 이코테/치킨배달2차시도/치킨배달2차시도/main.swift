//
//  main.swift
//  치킨배달2차시도
//
//  Created by Jung peter on 10/11/22.
//

import Foundation

func combi<T>(_ nums: [T], _ targetNum: Int) -> [[T]] {
    var result = [[T]]()
    
    func combination(_ index: Int, _ nowCombi: [T]) {
        if nowCombi.count == targetNum {
            result.append(nowCombi)
            return
        }
        
        for i in index..<nums.count {
            combination(i+1, nowCombi + [nums[i]])
        }
    }
    
    combination(0, [])
    return result
}

func distance(from: (x: Int, y: Int), tos: [(x: Int, y: Int)]) -> Int {
    var minDist = Int.max
    for to in tos {
        minDist = min(minDist, abs(to.x - from.x) + abs(to.y - from.y))
    }
    return minDist
}

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]

var map = [[Int]]()
for _ in 0..<n {
    map.append(readLine()!.split(separator: " ").map { Int(String($0))!})
}
var houses : [(x: Int, y: Int)] = []
var chickens : [(x: Int, y: Int)] = []

for y in 0..<n {
    for x in 0..<n {
        if map[y][x] == 1 {
            houses.append((x: x, y: y))
        } else if map[y][x] == 2 {
            chickens.append((x: x, y: y))
        }
    }
}
var minDist = Int.max
let chickenCombination = combi(chickens, m)

for combination in chickenCombination {
    var chickenDist = 0
    
    for house in houses {
        chickenDist += distance(from: house, tos: combination)
    }
    
    minDist = min(minDist, chickenDist)
}

print(minDist)
