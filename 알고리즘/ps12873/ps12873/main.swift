//
//  main.swift
//  ps12873
//
//  Created by Jung peter on 4/14/23.
//

import Foundation

let n = Int(readLine()!)!

func nCr(arr: [Int], r) {
  var result: [Int] = []
  
  if 
}

func solution(_ n: Int) -> Int {
  if n == 1 { return 1}
  var queue: [Int] = [Int](repeating: 0, count: n)
  for i in queue.indices {
    queue[i] = i+1
  }
  var startIdx = 0
  var t = 1
  while queue.count > 1 {
    var step = t*t*t
    step = (startIdx + step - 1) % queue.count
    queue.remove(at: step)
    startIdx = step
    t += 1
  }
  return queue[0]
}


print(solution(n))
