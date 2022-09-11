//
//  main.swift
//  럭키스트레이트
//
//  Created by Jung peter on 9/12/22.
//

import Foundation

let input = readLine()!.map { Int(String($0))! }

let front = input[0..<(input.count / 2)].reduce(0, +)
let back = input[(input.count / 2)...].reduce(0, +)

if front == back {
    print("LUCKY")
} else {
    print("READY")
}

