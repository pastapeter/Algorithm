//
//  main.swift
//  kruskal
//
//  Created by Jung peter on 9/6/22.
//

import Foundation

func findParent(parent: inout [Int], x: Int) -> Int {
    // 루트노드가 아니라면, 재귀적
    if parent[x] != x {
        parent[x] = findParent(parent: &parent, x: parent[x])
    }
    return parent[x]
}

func unionParent(parent: inout [Int], a: Int, b: Int) {
    var a = findParent(parent: &parent, x: a)
    var b = findParent(parent: &parent, x: b)
    
    if a < b {
        parent[b] = a
    } else {
        parent[a] = b
    }
    
}

let ve = readLine()!.split(separator: " ").map { Int($0)!}
let v = ve[0]
let e = ve[1]
var parent = [Int](repeating: 0, count: v + 1)
parent = parent.enumerated().map { $0.offset }

var edges = [(Int, Int, Int)]()
var result = 0

for i in 0..<e {
    let abc = readLine()!.split(separator: " ").map { Int($0)! }
    let a = abc[0]
    let b = abc[1]
    let cost = abc[2]
    
    edges.append((cost, a, b))
    
}

edges.sort { $0.0 < $1.0 }

for edge in edges {
    let cost = edge.0
    let a = edge.1
    let b = edge.2
    
    if findParent(parent: &parent, x: a) != findParent(parent: &parent, x: b) {
        unionParent(parent: &parent, a: a, b: b)
        result += cost
    }
}

print(result)
