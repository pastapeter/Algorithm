//
//  main.swift
//  ps1520
//
//  Created by Jung peter on 3/20/23.
//

/*
 500 * 500 = 250000
 */

import Foundation

struct Coor: Hashable {
  var x: Int
  var y: Int
}

let mn = readLine()!.split(separator: " ").map { Int(String($0))!}
let m = mn[0]
let n = mn[1]
let dx = [-1,1,0,0]
let dy = [0,0,-1,1]

var board: [[Int]] = []

for _ in 0..<m {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  board.append(temp)
}

func isRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < n && y >= 0 && y < m
}

func getCells() {
  
}

func dfs(start: Coor) {
  
}




