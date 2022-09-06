//
//  main.swift
//  teammake
//
//  Created by Jung peter on 9/6/22.
//

import Foundation

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

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]
var parent = [Int](repeating: 0, count: n+1)
parent = parent.enumerated().map { $0.offset }

for i in 0..<m {
    let cab = readLine()!.split(separator: " ").map { Int($0)!}
    let command = cab[0]
    let a = cab[1]
    let b = cab[2]
    
    if command == 0 {
        unionParent(parent: &parent, a: a, b: b)
    } else {
        findParent(parent: &parent, x: a) == findParent(parent: &parent, x: b) ? print("YES") : print("NO")
    }
}
