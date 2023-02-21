//
//  main.swift
//  ps2342
//
//  Created by Jung peter on 2/20/23.
//

import Foundation

var graph: [[Int]] = [[0,2,2,2,2],
                      [2,0,3,4,3],
                      [2,3,0,3,4],
                      [2,4,3,0,3],
                      [2,3,4,3,0]]

var commands = readLine()!.split(separator: " ").map { Int(String($0))!}
commands.removeLast()

var dp: [[[Int]]] = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 4000001, count: 5), count: 5), count: 1000001)


func add(to: Int, from: Int) -> Int {
  if from == 0 {
    if to == 0 { return 0}
    else { return 2}
  } else if from == to {
    return 1
  } else {
    return graph[from][to]
  }
}

func solve(i: Int, left: Int, right: Int) -> Int {
  
  if i >= commands.count { return 0 }

  if dp[i][left][right] != 4000001 {
    return dp[i][left][right]
  }
  
  dp[i][left][right] = min(solve(i: i+1, left: left, right: commands[i]) + add(to: commands[i], from: right), solve(i: i+1, left: commands[i], right: right) + add(to: commands[i], from: left))

  return dp[i][left][right]
  
}

print(solve(i: 0, left: 0, right: 0))

//dp[0][commands[0]][0] = 2
//dp[0][0][commands[0]] = 2
//
//for i in 1..<commands.count {
//
//  for right in 0..<5 {
//    for left in 0..<5 {
//      var add = add(to: commands[i], from: left)
//      dp[i][commands[i]][right] = min(dp[i][commands[i]][right], dp[i-1][left][right] + add)
//    }
//  }
//
//
//  for left in 0..<5 {
//    for right in 0..<5 {
//      var add = add(to: commands[i], from: right)
//      dp[i][left][commands[i]] = min(dp[i][left][commands[i]], dp[i-1][left][right] + add)
//    }
//  }
//}
//
//var minInt = 4000001
//for y in 0..<5 {
//  minInt = min(minInt, dp[commands.count-1][y][commands.last!])
//}
//for x in 0..<5 {
//  minInt = min(minInt, dp[commands.count-1][commands.last!][x])
//}

//print(minInt)
