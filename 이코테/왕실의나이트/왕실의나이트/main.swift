//
//  main.swift
//  왕실의나이트
//
//  Created by Jung peter on 8/18/22.
//

import Foundation

let location = readLine()!.map { "\($0)" }
let col = [" ","a","b","c","d","e","f","g","h"]
let row = [0,1,2,3,4,5,6,7,8]

let steps = [(-2, -1), (-2, 1), (1, -2), (1, 2), (-1, 2), (-1, -2), (2, 1), (2, -1)]
var result = 0

for step in steps {
    let nextRow = row.firstIndex(of: Int(location[1])!)! + step.0
    let nextCol = col.firstIndex(of: location[0])! + step.1
    
    if nextCol >= 1 && nextCol <= 8 && nextRow >= 1 && nextRow <= 8 {
        result += 1
    }

}

print(result)



