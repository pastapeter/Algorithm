//
//  main.swift
//  ps20056
//
//  Created by Jung peter on 3/16/23.
//

import Foundation

struct Fireball: Equatable {
  var x: Int
  var y: Int
  var m: Int
  var s: Int
  var d: Int
  
  func move(len: Int) -> Self {
    var ny = (dy[d] * s + y) % len
    var nx = (dx[d] * s + x) % len
    if nx < 0 { nx += len}
    if ny < 0 { ny += len}
    return Fireball(x: nx, y: ny, m: m, s: s, d: d)
  }
}

let nmk = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nmk[0]
let m = nmk[1]
let k = nmk[2]
let dx = [0, 1, 1, 1, 0, -1, -1, -1]
let dy = [-1, -1, 0, 1, 1,1,0,-1]
var board = [[[Fireball]]](repeating: [[Fireball]](repeating: [Fireball](), count: n), count: n)
var fireballs = [Fireball]()
for _ in 0..<m {
  let tmp = readLine()!.split(separator: " ").map { Int(String($0))!}
  var fireball = Fireball(x: tmp[1]-1, y: tmp[0]-1, m: tmp[2], s: tmp[3], d: tmp[4])
  fireballs.append(fireball)
}

func move() {
  fireballs = fireballs.map{ $0.move(len: n)}
  board = [[[Fireball]]](repeating: [[Fireball]](repeating: [Fireball](), count: n), count: n)
  fireballs.forEach { board[$0.y][$0.x].append($0)}
}

func mixFireballs(balls: [Fireball]) -> [Fireball] {
  var m = 0
  var s = 0
  var dlist: Set<Bool> = []
  balls.forEach {
    m += $0.m
    s += $0.s
    dlist.insert($0.d.isMultiple(of: 2))
  }
  m = m / 5
  s = s / balls.count
  let d: [Int] = dlist.count > 1 ? [1,3,5,7] : [0,2,4,6]
  return d.map { return Fireball(x: balls.first!.x, y: balls.first!.y, m: m, s: s, d: $0) }.filter { $0.m > 0}
}

func merge() {
  let tmplist = board.flatMap { $0}.filter { $0.count >= 2 }
  tmplist.forEach {
    let new = mixFireballs(balls: $0)
    board[$0.first!.y][$0.first!.x] = new
  }
  fireballs = board.flatMap {$0}.flatMap {$0}
}

for _ in 0..<k {
  move()
  merge()
}
var ans = 0
fireballs.forEach { ans += $0.m }
print(ans)
