//
//  main.swift
//  rain
//
//  Created by Jung peter on 11/11/22.
//

import Foundation

let hw = readLine()!.split(separator: " ").map { Int(String($0))!}
let h = hw[0]
let w = hw[1]
let water = readLine()!.split(separator: " ").map { Int(String($0))! }
var map = [[Int]](repeating: [Int](repeating: 1, count: w), count: h)
var result = 0

water.enumerated().forEach {
    for i in 0..<$0.element {
        map[h-i-1][$0.offset] = 0
    }
}

for y in 0..<h {
    for x in 0..<w {
        if map[y][x] == 0 {continue}
        if (x == 0 || x == w-1) && (map[y][x] == 1) { map[y][x] = -1 }
    }
}

for y in 0..<h {
    var left = 0
    var right = w-1
    while right >= 0 {
        if map[y][right] == 1 && (map[y][right-1] == -1 || map[y][right+1] == -1) {
            map[y][right] = -1
        }
        right -= 1
    }
    
    while left < w {
        if map[y][left] == 1 && (map[y][left-1] == -1 || map[y][left+1] == -1) {
            map[y][left] = -1
        }
        left += 1
    }
}

for y in 0..<h {
    for x in 0..<w {
        if map[y][x] == 1 {
            result += 1
        }
    }
}

print(result)
