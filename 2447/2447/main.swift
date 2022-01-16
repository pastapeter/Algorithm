//
//  main.swift
//  2447
//
//  Created by abc on 2021/06/30.
//

import Foundation

var input = Int(readLine()!)!
var matrix = [[Character]](repeating: [Character](repeating: " ", count: 7000), count: 7000)


func printStar(_ n: Int, _ x: Int, _ y: Int){
    if n == 1{
        matrix[y][x] = "*"
        return
    }
    
    let val = n/3

    for i in 0..<3 {
        for j in 0..<3{
            if i == 1 && j == 1 {
                continue
            } else {
                printStar(val, x+j*val, y+i*val)
            }
        }
    }
}


printStar(input, 0, 0)
for i in 0..<input{
    for j in 0..<input{
        print(matrix[i][j], terminator: "")
    }
    print()
}

