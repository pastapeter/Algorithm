//
//  main.swift
//  자물쇠와열쇠
//
//  Created by Jung peter on 9/13/22.
//

import Foundation

func rotate(_ key: [[Int]]) -> [[Int]] {
    var result = [[Int]](repeating: [Int](repeating: 0, count: key.count), count: key.count)
    for y in key.indices {
        for x in key[y].indices {
            result[x][key.count - 1 - y] = key[y][x]
        }
    }
    return result
}

func check(newlock: [[Int]]) -> Bool {
    var length = newlock.count / 3
    for i in length..<(length*2) {
        for j in length..<(length*2) {
            if newlock[i][j] != 1 {
                return false
            }
        }
    }
    return true
}


func solution(_ key:[[Int]], _ lock:[[Int]]) -> Bool {
   
    var key = key
    let n = lock.count
    let m = key.count
    
    var newLock = [[Int]](repeating: [Int](repeating: 0, count: n*3), count: n*3)
    
    for i in 0..<n {
        for j in 0..<n {
            newLock[i+n][j+n] = lock[i][j]
        }
    }
    
    for _ in 0..<4 {
        key = rotate(key)
        for x in 0..<(n*2) {
            for y in 0..<(n*2) {
                
                for i in 0..<m {
                    for j in 0..<m {
                        newLock[x+i][y+j] += key[i][j]
                    }
                }
                
                if check(newlock: newLock) == true {
                    return true
                }
                
                for i in 0..<m {
                    for j in 0..<m {
                        newLock[x+i][y+j] -= key[i][j]
                    }
                }
            }
        }
    }
    
    return false
}

print(solution([[0, 0, 0], [1, 0, 0], [0, 1, 1]], [[1, 1, 1], [1, 1, 0], [1, 0, 1]]))
