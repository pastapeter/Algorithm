//
//  main.swift
//  ps_6603
//
//  Created by Jung peter on 2/27/23.
//

import Foundation
//로또 combination을 풀지말고, 백트래킹으로 한번 풀어보자
var combi = [Int](repeating: 0, count: 13)
var s: [Int] = []
var k = 0
func dfs(start: Int, depth: Int) {
  if depth == 6 {
    for i in 0..<6 {
      print(combi[i], terminator: " ")
    }
    print("")
    return
  }
  
  for i in start..<k {
    combi[depth] = s[i]
    dfs(start: i+1, depth: depth+1)
  }
  
}

while true {
  s = readLine()!.split(separator: " ").map { Int(String($0))!}
  if s[0] == 0 { break }
  k = s.removeFirst()
  dfs(start: 0, depth: 0)
  print("")
}


