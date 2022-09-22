//
//  main.swift
//  기둥과보
//
//  Created by Jung peter on 9/20/22.
//

import Foundation

func isColAvailable(x: Int, y: Int, n: Int, map: [[(Bool, Bool)]]) -> Bool {
    // 바닥, 기둥 위, 보의 왼쪽일 경우
    if y == n || map[y+1][x].0 == true || map[y][x].1 == true {
        return true
    }
    // 보의 오른쪽 위일 경우
    if x > 0 {
        if map[y][x-1].1 == true {
            return true
        }
    }
   return false
}

func isPaperAvailable(x: Int, y:Int, n: Int, map: [[(Bool, Bool)]]) -> Bool {
    // 보의 왼쪽 기둥 위
    if y < n && map[y+1][x].0 {
        return true
    }
    // 보의 오른쪽이 기둥 위
    if x < n && y < n {
        if map[y+1][x+1].0 {
            return true
        }
    }
    
    // 보가 양갈래
    if x > 0 && x < n {
        if map[y][x-1].1 && map[y][x+1].1 {
            return true
        }
    }
    return false
}

func checkRightStructure(x: Int, y: Int, type: Int, n: Int, map: [[(Bool, Bool)]]) -> Bool {
    var map = map
    var flag = false
    if type == 0 {
        map[y][x].0 = false
        for i in map.indices {
            for j in map.indices {
                if isPaperAvailable(x: j, y: i, n: n, map: map) && isColAvailable(x: j, y: i, n: n, map: map){
                    return true
                }
            }
        }
    } else {
        map[y][x].1 = false
        for i in map.indices {
            for j in map.indices {
                if isPaperAvailable(x: j, y: i, n: n, map: map) && isColAvailable(x: j, y: i, n: n, map: map){
                    return true
                }
            }
        }
    }
    return false
}

func changeIndex(coor: (x: Int, y: Int), n: Int) -> (x: Int, y: Int) {
    return (coor.x, n - coor.y)
}


func uninstall(coordindate: (x: Int, y: Int), type: Int, map: inout [[(Bool, Bool)]]) {
    //기둥
    
    let n = map.count - 1
    let newcoor = changeIndex(coor: coordindate, n: n)
    if type == 0 {
        if checkRightStructure(x: newcoor.x, y: newcoor.y, type: 0, n: n, map: map) {
            map[newcoor.y][newcoor.x].0 = false
        }
    } else { // 보
        if checkRightStructure(x: newcoor.x, y: newcoor.y, type: 1, n: n, map: map) {
            map[newcoor.y][newcoor.y].1 = false
        }
    }
}

func install(coordindate: (x: Int, y: Int), type: Int, map: inout [[(Bool, Bool)]]) {
    let n = map.count - 1
    let x = changeIndex(coor: coordindate, n: n).x
    let y = changeIndex(coor: coordindate, n: n).y
    // 기둥
    if type == 0 {
        if isColAvailable(x: x, y: y, n: n, map: map) {
            map[y][x].0 = true
        }
    } else { //보
        if isPaperAvailable(x: x, y: y, n: n, map: map) {
            map[y][x].1 = true
        }
    }
}

func makeResult(map: [[(Bool, Bool)]]) -> [[Int]] {
    var result = [[Int]]()
    let n = map.count

    for y in 0..<n {
        for x in 0..<n {
            if map[y][x].0 == true {
                result.append([x, n-y-1, 0])
            }
            if map[y][x].1 == true {
                result.append([x, n-y-1, 1])
            }
        }
    }
    
    result.sort {
        if $0[0] < $1[0] {
            return true
        } else if $0[0] == $1[0] {
            if $0[1] < $1[1] {
                return true
            } else if $0[1] == $1[1]{
                return $0[2] < $1[2]
            } else {
                return false
            }
        } else {
            return false
        }
    }
        
    return result
}

func solution(_ n:Int, _ build_frame:[[Int]]) -> [[Int]] {
    
    // 기둥, 보
    var map = [[(Bool, Bool)]](repeating: [(Bool, Bool)](repeating: (false, false), count: n+1), count: n+1)
    
    for frame in build_frame {
        
        let coordinate = (x:frame[0], y: frame[1])
        
        if frame[3] == 0 {
            uninstall(coordindate: coordinate, type: frame[2], map: &map)
        } else {
            install(coordindate: coordinate, type: frame[2], map: &map)
        }
        
    }

    return makeResult(map: map)
}

print(solution(5, [[0,0,0,1],[2,0,0,1],[4,0,0,1],[0,1,1,1],[1,1,1,1],[2,1,1,1],[3,1,1,1],[2,0,0,0],[1,1,1,0],[2,2,0,1]]))


