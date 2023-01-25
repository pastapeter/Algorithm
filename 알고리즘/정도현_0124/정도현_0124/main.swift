//
//  main.swift
//  정도현_0124
//
//  Created by Jung peter on 1/25/23.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nm[0]
let m = nm[1]
let boss = 1
var complements = [Int](repeating: 0, count: n+1)
let supervisors = readLine()!.split(separator: " ").map { Int(String($0))! }
var supervisorsDic: [Int: [Int]] = [:]
for i in supervisors.indices {
  supervisorsDic.updateValue(((supervisorsDic[supervisors[i]] ?? []) + [i+1]), forKey: supervisors[i])
}
var dp = [Int](repeating: 0, count: n+1)

func findchild(parent: Int) {
  if supervisorsDic[parent] == nil { return }
  supervisorsDic[parent]!.forEach {
    dp[$0] += dp[parent]
    findchild(parent: $0)
  }
}

for _ in 0..<m {
  let mancom = readLine()!.split(separator: " ").map { Int(String($0))! }
  dp[mancom[0]] += mancom[1]
}

findchild(parent: 1)

for i in 1..<dp.count {
  print(dp[i], terminator: " ")
}

