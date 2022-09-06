//
//  main.swift
//  도시분할계획
//
//  Created by Jung peter on 9/6/22.
//

import Foundation

//최소신장트리 - 크루스칼 - union find

func findParent(parent: inout [Int], x: Int) -> Int {
    if parent[x] != x {
        parent[x] = findParent(parent: &parent, x: parent[x])
    }
    return parent[x]
}

func unionParent(parent: inout [Int], a: Int, b: Int) {
    var a = findParent(parent: &parent, x: a)
    var b = findParent(parent: &parent, x: b)
    if a<b {
        parent[b] = a
    } else {
        parent[a] = b
    }
}

let nm = readLine()!.split(separator: " ").map { Int($0)!}
let n = nm[0]
let m = nm[1]
var parent = [Int](repeating: 0, count: n + 1)
parent = parent.enumerated().map { $0.offset }
var edges = [(a: Int, b: Int, c: Int)]()
var results = [Int]()
var result = 0


for i in 0..<m {
    let abc = readLine()!.split(separator: " ").map { Int($0)! }
    let a = abc[0]
    let b = abc[1]
    let c = abc[2]
    edges.append((a:a, b:b, c:c))
}

edges.sort { $0.c < $1.c}
var last = 0

for edge in edges {

    let a = edge.a
    let b = edge.b
    let c = edge.c
    
    if findParent(parent: &parent, x: a) != findParent(parent: &parent, x: b) {
        unionParent(parent: &parent, a: a, b: b)
        result += c
        last = c
    }
    
}

// 최소신장트리 하나만들고, 가장 마지막이 간선이 제일 크니깐 짤라준다 마인드
print(result - last)


