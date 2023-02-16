//
//  main.swift
//  pro_72413
//
//  Created by Jung peter on 2/16/23.
//

import Foundation

func findMin(arr: [Int]) -> Int {
  var minINt = Int.max
  for i in arr {
    if i < minINt && i != 0 {
      minINt = i
    }
  }
  return minINt
}

func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
  
  var floyd = [[Int]](repeating: [Int](repeating: Int.max, count: n+1), count: n+1)
  
  for y in 1...n {
    floyd[y][y] = 0
  }
  
  for fare in fares {
    floyd[fare[0]][fare[1]] = fare[2]
    floyd[fare[1]][fare[0]] = fare[2]
  }
  
  for k in 1...n {
    for y in 1...n {
      for x in 1...n {
        if floyd[y][k] == Int.max || floyd[k][x] == Int.max {
          floyd[y][x] = floyd[y][x]
        } else {
          floyd[y][x] = min(floyd[y][x], floyd[y][k] + floyd[k][x])
        }
      }
    }
  }

  var answer = Int.max
  for k in 1...n {
    if !(floyd[s][k] == Int.max || floyd[k][a] == Int.max || floyd[k][b] == Int.max) {
      answer = min(answer, floyd[s][k] + floyd[k][a] + floyd[k][b])
    }
  }
  return answer
}


print(solution(6, 4, 6, 2, [[4, 1, 10], [3, 5, 24], [5, 6, 2], [3, 1, 41], [5, 1, 24], [4, 6, 50], [2, 4, 66], [2, 3, 22], [1, 6, 25]]))
print(solution(7, 3, 4, 1, [[5, 7, 9], [4, 6, 4], [3, 6, 1], [3, 2, 3], [2, 1, 6]]))
print(solution(6, 4, 5, 6, [[2,6,6], [6,3,7], [4,6,7], [6,5,11], [2,5,12], [5,3,20], [2,4,8], [4,3,9]]))
