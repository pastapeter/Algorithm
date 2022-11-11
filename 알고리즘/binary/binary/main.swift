//
//  main.swift
//  이진수
//
//  Created by Jung peter on 11/7/22.
//

import Foundation

let t = Int(readLine()!)!

for _ in 0..<t {
    let n = Int(readLine()!)!
    let result = String(n, radix: 2).map { Int(String($0))! }.reversed()
    var answer: [String] = []
    result.enumerated().forEach {
        if $0.element == 1 {
            answer.append(String($0.offset))
        }
    }
    print(answer.joined(separator: " "))
}




