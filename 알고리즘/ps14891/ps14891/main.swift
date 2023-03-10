//
//  main.swift
//  ps14891
//
//  Created by Jung peter on 3/7/23.
//

import Foundation

var chain1 = readLine()!.map { Int(String($0))!}
var chain2 = readLine()!.map { Int(String($0))!}
var chain3 = readLine()!.map { Int(String($0))!}
var chain4 = readLine()!.map { Int(String($0))!}

var chains = [chain1, chain2, chain3, chain4]
// 맞닿아있느느부분
//chains[0][2], chains[1][6]
// 1번체인 2
// 2번체인 2, 6
// 3번체인 2, 6
// 4번체인 6

// N극 0, S극 1

func isMatch(chainIdx1: Int, chainIdx2: Int) -> Bool {
  return true
}

func next(start: Int) -> [Int] {
  var res: [Int] = []
  for i in [1,-1] {
    if start+i > 0 && start+i < 4 {
      res.append(start+i)
    }
  }
  return res
}

func rotateRight(idx: Int) {
  
}

func rotateLeft(idx: Int) {
  
}

func rotate(start: Int, dir: Int) {
  if dir == 1 {
    var nextChainIdx = next(start: start)
    for idx in nextChainIdx {
      if isMatch(chainIdx1: start, chainIdx2: idx) { // 맞다면?
        
      }
    }
  } else {
    
  }
}

func score() -> Int {
  var res = 0
  chains.enumerated().forEach {
    if $0.element[0] == 1 {
      res += Int(pow(2.0, Double($0.offset)))
    }
  }
  return res
}

let k = Int(readLine()!)!
for _ in 0..<k {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  let rotateChain = temp[0]
  //  1인경우가 시계방향, -1인 경우가 반시계방향
  let dir = temp[1]
  
  
  
}
