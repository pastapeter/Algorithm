//
//  main.swift
//  상하좌우
//
//  Created by Jung peter on 8/18/22.
//

import Foundation

let n = Int(readLine()!)!
let input = readLine()!.split(separator: " ").map { String($0) }

var location = (1, 1)
let dx = [0, 0, -1, 1]
let dy = [-1, 1, 0, 0]
let moveType = ["L", "R", "U", "D"]

//방법2
for direction in input {
    var nx = location.0
    var ny = location.1
    
    for i in moveType.indices {
        if direction == moveType[i] {
            nx = location.0 + dx[i]
            ny = location.1 + dy[i]
        }
    }
    
    if nx < 1 || ny < 1 || nx > n || ny > n {
        continue
    }
    location.0 = nx
    location.1 = ny
}


//방법1
//for direction in input {
//    if direction == "R" && location.1 < n {
//        location = (location.0, location.1 + 1)
//    } else if direction == "L" && location.1 > 1 {
//        location = (location.0, location.1 - 1)
//    } else if direction == "U" && location.0 > 1 {
//        location = (location.0 - 1, location.1)
//    } else if direction == "D" && location.0 < n {
//        location = (location.0 + 1, location.1)
//    }
//}

print(location)
