//
//  main.swift
//  게임개발
//
//  Created by Jung peter on 8/18/22.
//

import Foundation

let n = readLine()!.split(separator: " ").map { Int($0)!}
let user = readLine()!.split(separator: " ").map { Int($0)!}
// x = user[0], y = user[1], direction =
var x = user[0]
var y = user[1]
var direction = user[2]
var count = 0
var result = 1

var map = [[Int]](repeating: [], count: n[0])
var visited = [[Int]](repeating: [Int](repeating: 0, count: n[1]), count: n[0])
visited[x][y] = 1

for i in 0..<n[0] {
    let temp = readLine()!.split(separator: " ").map {Int($0)!}
    map[i] += temp
}

func turnLeft(direction: Int) -> Int {
    var new = direction - 1
    if new < 0 {
        new += 4
    }
    return new
}

let dx = [-1, 0, 1, 0]
let dy = [0, 1, 0, -1]


while true {
    direction = turnLeft(direction: direction)
    var nx = x + dx[direction]
    var ny = y + dy[direction]
    
    // 육지 + 가보지않은곳?
    if map[nx][ny] == 0 && visited[nx][ny] == 0 {
        visited[nx][ny] = 1
        x = nx
        y = ny
        count = 0
        result += 1
        continue
    } else { // 회전한 다음에 정면에 갈수 없다면?
        count += 1
    }
    
    // 다시 돌아왔다는 이야기
    if count == 4 {
        //뒤에가 바다면?
        nx = x - dx[direction]
        ny = y - dy[direction]
        
        if map[nx][ny] == 0 {
            x = nx
            y = ny
        } else {
            break
        }
        count = 0
    }
}

print(result)


