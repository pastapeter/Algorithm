//
//  main.swift
//  뱀
//
//  Created by Jung peter on 9/18/22.
//

import Foundation

enum Direction: String, CaseIterable {
    case R, D, L, U
}

let n = Int(readLine()!)!
let k = Int(readLine()!)!
var appleLocation: [(Int, Int)] = []
for _ in 0..<k {
    let location = readLine()!.split(separator: " ").map { Int($0)! }
    appleLocation.append((location[0]-1, location[1]-1))
}

let l = Int(readLine()!)!
var directions: [(Int, String)] = []
for _ in 0..<l {
    let direction = readLine()!.split(separator: " ").map { String($0) }
    directions.append((Int(direction[0])!, direction[1]))
}

var snake: [(Int, Int)] = []

func turnRight(direction: Direction) -> Direction {
    return Direction.allCases[(Direction.allCases.firstIndex(of: direction)! + 1) % 4]
}

func turnLeft(direction: Direction) -> Direction {
    return Direction.allCases[(Direction.allCases.firstIndex(of: direction)! + 3) % 4]
}

func move(row: Int, col: Int, direction: Direction) -> (Int, Int) {
    
    var result = (row, col)
    
    // 몸길이를 늘려서 머리를 다음칸으로
    
    if direction == .R {
        result.1 += 1
    } else if direction == .D {
        result.0 += 1
    } else if direction == .L {
        result.1 -= 1
    } else {
        result.0 -= 1
    }
    
    //죽는지 확인하기
    if result.0 < 0 || result.0 >= n || result.1 < 0 || result.1 >= n {
        return (Int.min, Int.min)
    }
    
    if snake.contains(where: {
        return $0.0 == result.0 && $0.1 == result.1
    }) {
        return (Int.min, Int.min)
    }
    
    // 대가리추가
    snake.insert(result, at: 0)

    if let removeIndex = appleLocation.firstIndex(where: {
        return $0.0 == result.0 && $0.1 == result.1
    }) {
        appleLocation.remove(at: removeIndex)
    } else {
        snake.removeLast()
    }
    return result
}

var currentPos = (0,0)
snake.append(currentPos)
var currentDirection = Direction.R
var length = 1
var map = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)

// 사과 나타내기
for location in appleLocation {
    map[location.0][location.1] = 1
}

func solution() -> Int {
    
    var count = 0

    for direction in directions {
        
        // 움직이고
        for sec in count..<direction.0 {
            count += 1
            currentPos = move(row: currentPos.0, col: currentPos.1, direction: currentDirection)
            if currentPos == (Int.min, Int.min) {
                return count
            }
        }
        
        if direction.1 == "D" {
            currentDirection = turnRight(direction: currentDirection)
        } else {
            currentDirection = turnLeft(direction: currentDirection)
        }
        
    }
    
    while currentPos != (Int.min, Int.min) {
        count += 1
        currentPos = move(row: currentPos.0, col: currentPos.1, direction: currentDirection)
    }
    
    return count
}

print(solution())

