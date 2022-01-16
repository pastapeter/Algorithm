//
//  main.swift
//  9095
//
//  Created by abc on 2021/07/12.
//

import Foundation

func solution(){
    let input = Int(readLine()!)!
    var num = [Int](repeating: 0, count: input)
    var matrix = [[Int]](repeating: [0,1,2,4,0,0,0,0,0,0,0,0], count: input)

    for i in 0..<input{
        num[i] = Int(readLine()!)!
    }

    for i in 0..<num.count {
        if num[i] == 1{
            print(1)
        } else if num[i] == 2{
            print(2)
        } else if num[i] == 3{
            print(4)
        } else {
            for j in 4...num[i]{
                matrix[i][j] = matrix[i][j-1] + matrix[i][j-2] + matrix[i][j-3]
            }
            print(matrix[i][num[i]])
        }
    }
}

solution()


