//
//  main.swift
//  모험가길드
//
//  Created by Jung peter on 9/7/22.
//

import Foundation

var n = Int(readLine()!)!
var people = readLine()!.split(separator: " ").map { Int($0)! }
var result = 0

// 이건 가장 적게만드는법
//people = people.sorted { $0 > $1 }
//while !people.isEmpty {
//    let person = people.removeFirst()
//    if people.count >= person - 1 {
//        for _ in 0..<person - 1 {
//            people.removeLast()
//        }
//        result += 1
//    }
//}
//print(result)

// 가장 많이 만드는법
people = people.sorted()
var group = [Int]()
for person in people {
    group.append(person)
    if group.count >= person {
        result += 1
        group.removeAll()
    }
}
print(result)
