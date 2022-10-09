//
//  main.swift
//  감시피하기
//
//  Created by Jung peter on 10/6/22.
//

import Foundation

func combi<T>(_ nums: [T], _ targetNum: Int) -> [[T]] {
    var result = [[T]]()
    
    func combination(_ index: Int, _ nowCombi: [T]) {
        if nowCombi.count == targetNum {
            result.append(nowCombi)
            return
        }
// 특정 인덱스부터 들어온 배열의 갯수까지 돌면서 조합을 찾는다.
        for i in index..<nums.count {
            combination(i+1, nowCombi + [nums[i]])
        }
    }
    
    combination(0, [])
    return result
}

let n = Int(readLine()!)!
var map = [[String]]()
var studentCoor = [(x: Int, y: Int)]()
var teacherCoor = [(x: Int, y: Int)]()
var adjacentCell = [(x: Int, y: Int)]()

for _ in 0..<n {
    map.append(readLine()!.split(separator: " ").map { String($0) })
}

let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]

for y in 0..<n {
    for x in 0..<n {
        if map[y][x] == "S" {
            studentCoor.append((x: x, y: y))
        } else if map[y][x] == "T" {
            teacherCoor.append((x: x, y: y))
        } else {
            adjacentCell.append((x: x, y: y))
        }
    }
}


func canSeeStudent(start: (x: Int, y: Int), dx: Int, dy: Int, map: [[String]]) -> Bool {
    
    let nx = start.x + dx
    let ny = start.y + dy
    
    // 교실벽에 막힘
    if ny < 0 || nx < 0 || nx >= n || ny >= n {
        return false
    }
    
    
    // 갈곳이 남아있음
    if map[ny][nx] == "X" {
        return canSeeStudent(start: (x: nx, y: ny), dx: dx, dy: dy, map: map)
    // 내갈
    } else if map[ny][nx] == "O" || map[ny][nx] == "T" {
        return false
    } else {
        return true
    }
    
}

//조합으로 조지기

func solution() -> String {
    let combination = combi(Array(adjacentCell), 3)
    var resultArr = [[Bool]]()
    for combi in combination {
        // 사람의 눈은 하나로밖에 못봄
        var newMap = map
        // 3개를 놓아야함
        newMap[combi[0].y][combi[0].x] = "O"
        newMap[combi[1].y][combi[1].x] = "O"
        newMap[combi[2].y][combi[2].x] = "O"
        var result = [Bool]()
        
        for teacher in teacherCoor {
            for i in 0..<4 {
                result.append(canSeeStudent(start: (x: teacher.x, y: teacher.y), dx: dx[i], dy: dy[i], map: newMap))
            }
        }
        resultArr.append(result)
        
    }
    
    for result in resultArr {
        if Set(result).count == 1 && result[0] == false {
            return "YES"
        }
    }
    
   return "NO"
}

print(solution())



