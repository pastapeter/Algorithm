//
//  main.swift
//  ps9372
//
//  Created by Jung peter on 2/9/23.
//

import Foundation

func bfs(start: Int, board: [[Int]]) -> Int {
  var queue : [Int] = [start]
  var visited: Set<Int> = [start]
  var result = 0
  
  while !queue.isEmpty {
    
    var node = queue.removeFirst()
    
    for newNode in board[node] {
      if !visited.contains(newNode) {
        queue.append(newNode)
        visited.insert(newNode)
        result += 1
      }
    }
    
  }
  
 return result
}

let t = Int(readLine()!)!
for _ in 0..<t {
  
  let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
  let n = nm[0]
  let m = nm[1]
  var board = [[Int]](repeating: [], count: n)
  
  
  for i in 0..<m {
    let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
    board[temp[0]-1] += [temp[1]-1]
    board[temp[1]-1] += [temp[0]-1]
  }
  
  print(bfs(start: 0, board: board))
}


