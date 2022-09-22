//
//  main.swift
//  치킨배달
//
//  Created by Jung peter on 9/22/22.
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

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]

var map = [[Int]]()

for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    map.append(row)
}

var chicken : [(Int, Int)] = []
var house : [(Int, Int)] = []
var results: [(Int, Int, Int)] = []


for i in map.indices {
    for j in map[i].indices {
        if map[i][j] == 2 {
            chicken.append((j, i))
        } else if map[i][j] == 1 {
            house.append((j, i))
        }
    }
}

var candidates = combi(chicken, m)
var chickenDist: [(Int, Int)] = []

for (index, candidate) in candidates.enumerated() {
    var count = 0
    for h in house {
        var dist: [Int] = []
        for c in candidate {
            dist.append(abs(c.0 - h.0) + abs(c.1 - h.1))
        }
        count += dist.min()!
    }
    chickenDist.append((index, count))
}

print(chickenDist.min(by: { $0.1 < $1.1})!.1)


