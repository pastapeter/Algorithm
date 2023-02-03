//
//  main.swift
//  정도현_0201
//
//  Created by Jung peter on 2/2/23.
//

import Foundation

func solution(_ m: Int, _ n: Int, _ board: [String]) -> Int {
  var result = 0
  var contentBoard: [[String]] = []
  var stackBoard = [[String]](repeating: [String](repeating: "", count: m), count: n)
  
  for content in board {
    contentBoard.append(content.map { String($0) })
  }
  
  // stack으로 만들기
  for y in 0..<m {
    for x in 0..<n {
      stackBoard[x][y] = contentBoard[y][x]
    }
  }
  
  while true {
    
    var completed = true
    
    for y in 0..<m-1 {
      for x in 0..<n-1 {
        if Set([contentBoard[y][x], contentBoard[y+1][x], contentBoard[y+1][x+1], contentBoard[y][x+1]]).count == 1 && contentBoard[y][x] != "0" {
          stackBoard[x][y] = "1"
          stackBoard[x+1][y] = "1"
          stackBoard[x][y+1] = "1"
          stackBoard[x+1][y+1] = "1"
          completed = false
        }
      }
    }
    
    for i in stackBoard.indices {
      stackBoard[i].removeAll(where: { $0 == "1"})
      let blank = m - stackBoard[i].count
      stackBoard[i].insert(contentsOf: [String](repeating: "0", count: blank), at: 0)
    }
    
    for y in 0..<m {
      for x in 0..<n {
        contentBoard[y][x] = stackBoard[x][y]
      }
    }
    
    if completed == true { break }
    
  }
  
  for y in 0..<m {
    for x in 0..<n {
      if contentBoard[y][x] == "0" { result += 1}
    }
  }
  
  return result
}




print(solution(4, 5, ["CCBDE", "AAADE", "AAABF", "CCBBF"]))
