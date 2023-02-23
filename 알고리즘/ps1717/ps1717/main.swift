//
//  main.swift
//  ps1717
//
//  Created by Jung peter on 2/23/23.
//

import Foundation

let nm = readLine()!.split(separator: " ").map { Int( String($0))!}
let n = nm[0]
let m = nm[1]
var commands: [(Int, Int, Int)] = []
var sets = (0...n).map { $0 }

for _ in 0..<m {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  commands.append((temp[0], temp[1], temp[2]))
}

func findParent(child: Int) -> Int {
  if sets[child] != child {
    sets[child] = findParent(child: sets[child])
    return sets[child]
  } else {
    return child
  }
}

func union(a: Int, b: Int) {
  let aparent = findParent(child: a)
  let bparent = findParent(child: b)
  if aparent < bparent {
    sets[bparent] = aparent
  } else {
    sets[aparent] = bparent
  }
}

for command in commands {
  if command.0 == 0 {
    union(a: command.1, b: command.2)
  } else {
    if findParent(child: command.1) == findParent(child: command.2) {
      print("YES")
    } else {
      print("NO")
    }
  }
}
