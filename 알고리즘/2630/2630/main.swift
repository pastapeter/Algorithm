//
//  main.swift
//  2630
//
//  Created by abc on 2021/06/25.
//

import Foundation

var length = Int(readLine()!)!
var temp = [Int](repeating: 0, count: length)
var matrix = [[Int]](repeating: temp, count: length)

var blue = 0
var white = 0
var 기준 = 0

func dividePaper(_ matrix: [[Int]], _ startIndex: (Int, Int), _ endIndex: (Int, Int)){
    기준 = matrix[startIndex.1][startIndex.0]
    for y in (startIndex.1)...endIndex.1 {
        for x in (startIndex.0)...endIndex.0{
            if 기준 != matrix[y][x]{
                dividePaper(matrix, (startIndex.0, startIndex.1), ((startIndex.0 + endIndex.0)/2, (startIndex.1 + endIndex.1)/2))
                dividePaper(matrix, ((startIndex.0+endIndex.0)/2+1, startIndex.1), (endIndex.0, (startIndex.1 + endIndex.1)/2))
                dividePaper(matrix, (startIndex.0, (startIndex.1+endIndex.1)/2+1), ((startIndex.0+endIndex.0)/2, endIndex.1))
                dividePaper(matrix, ((startIndex.0+endIndex.0)/2+1, (startIndex.1+endIndex.1)/2+1), (endIndex.0, endIndex.1))
                return
            }
        }
    }
  
    if(기준 == 1){
        blue += 1
    } else {
        white += 1
    }
}

for i in 0..<length{
    let input = readLine()!
    let newInput = input.components(separatedBy: " ").map { value in
        return Int(value)!
    }
    for j in 0..<newInput.count{
        matrix[i][j] = newInput[j]
    }
}

dividePaper(matrix, (0,0), (length-1, length-1))
print(white)
print(blue)



