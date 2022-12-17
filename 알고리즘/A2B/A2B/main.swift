//
//  main.swift
//  A2B
//
//  Created by Jung peter on 12/17/22.
//

import Foundation

var result = Int.max

func dfs(start: Int, target: Int, cnt: Int) {
  if start == target {
    result = min(result, cnt)
    return
  } else if start > target {
    return
  } else {
    dfs(start: start * 2, target: target, cnt: cnt+1)
    dfs(start: Int("\(start)1")!, target: target, cnt: cnt+1)
  }
}

func solution(start: Int, target: Int) {
  dfs(start: start, target: target, cnt: 0)
  print(result == Int.max ? -1 : result + 1)
}

let input = readLine()!.split(separator: " ").map{ Int(String($0))!}
solution(start: input[0], target: input[1])



