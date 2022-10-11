//
//  main.swift
//  뱀2차시도
//
//  Created by Jung peter on 10/11/22.
//

import Foundation


// 0: 동, 1: 남, 2: 서, 3: 북
let dx = [1, 0, -1, 0]
let dy = [0, 1, 0, -1]
var count = 1

func changeDirection(curr: Int, command: String) -> Int {

    if command == "D" {
        return (curr+1)%4
    } else {
        return (curr+3)%4
    }
}

func move(dist: Int, direction: String?) -> Bool {
    for i in 0..<dist {
        // 다음 nx, ny
        let nx = snake.last!.x + dx[currentDirection]
        let ny = snake.last!.y + dy[currentDirection]
        
        // 죽어야하는 조건
        if nx < 0 || ny < 0 || nx >= n || ny >= n {
            return false
        }
        
        if snake.contains(where: {  $0.x == nx && $0.y == ny }){
            return false
        }
        
        if map[ny][nx] == 1 { // 사과있음
            map[ny][nx] = 0
            snake.append((x: nx, y: ny))
            count += 1
        } else { // 사과 없음
            snake.append((x: nx, y: ny))
            snake.removeFirst()
            count += 1
        }
    }
    if let direction = direction {
        currentDirection = changeDirection(curr: currentDirection, command: direction)
    }
    return true
}

let n = Int(readLine()!)!
let k = Int(readLine()!)!
var map = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)

for _ in 0..<k {
    let tmp = readLine()!.split(separator: " ").map { Int(String($0))! }
    map[tmp[0]-1][tmp[1]-1] = 1
}
let l = Int(readLine()!)!
var snake : [(x: Int, y: Int)] = [(x: 0, y: 0)]
var currentDirection: Int = 0
var second = 0

for _ in 0..<l {
    let vector = readLine()!.split(separator: " ").map { String($0) }
    var dist = Int(vector[0])!
    var direction = vector[1]
    let result = move(dist: dist - second, direction: direction)
    second = dist
    if !result {
        break
    }
}

while true {
    if !move(dist: 1, direction: nil) {
        break
    }
}

print(count)

