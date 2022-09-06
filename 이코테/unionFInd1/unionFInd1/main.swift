//
//  main.swift
//  unionFInd1
//
//  Created by Jung peter on 9/6/22.
//

import Foundation

func findParent(parent: inout [Int], x: Int) -> Int {
    // rootnode가 아니라면, rootnode 를 찾을때까지 재귀적 호출
    if parent[x] != x {
        parent[x] = findParent(parent: &parent, x: parent[x])
    }
    return parent[x]
}

// 두원소가 속한 집합합치기
func unionParent(parent: inout [Int], a: Int, b: Int) {
    var a = findParent(parent: &parent, x: a)
    var b = findParent(parent: &parent, x: b)
    if a < b {
        parent[b] = a
    } else {
        parent[a] = b
    }
}

// 노드의 개수와 간선의 개수 입력받기
let vc = readLine()!.split(separator: " ").map { Int($0)! }
let v = vc[0]
let e = vc[1]
var parent = [Int](repeating: 0, count: v + 1)
//부모 테이블 상에서, 부모를 자기 자신으로 초기화
parent = parent.enumerated().map { $0.offset }
var cycle = false

//union 연산을 각각 수행
for _ in 0..<e {
    let ab = readLine()!.split(separator: " ").map { Int($0)! }
    if findParent(parent: &parent, x: ab[0]) == findParent(parent: &parent, x: ab[1]) {
        cycle = true
        break
    } else {
        unionParent(parent: &parent, a: ab[0], b: ab[1])
    }
}

if cycle {
    print("사이클 발생")
} else {
    // 각 원소가 속한 집합 출력
    for i in 1..<v+1 {
        print(findParent(parent: &parent, x: i), terminator: " ")
    }


    print(parent)



}

