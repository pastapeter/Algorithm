//
//  main.swift
//  ps20056
//
//  Created by Jung peter on 3/16/23.
//

/*
 <문제>
 모든 파이어볼이 자신의 방향 di로 속력 si칸 만큼 이동한다.
 이동하는 중에는 같은 칸에 여러 개의 파이어볼이 있을 수도 있다.
 이동이 모두 끝난 뒤, 2개 이상의 파이어볼이 있는 칸에서는 다음과 같은 일이 일어난다.
 같은 칸에 있는 파이어볼은 모두 하나로 합쳐진다.
 파이어볼은 4개의 파이어볼로 나누어진다.
 나누어진 파이어볼의 질량, 속력, 방향은 다음과 같다.
 질량은 ⌊(합쳐진 파이어볼 질량의 합)/5⌋이다.
 속력은 ⌊(합쳐진 파이어볼 속력의 합)/(합쳐진 파이어볼의 개수)⌋이다.
 합쳐지는 파이어볼의 방향이 모두 홀수이거나 모두 짝수이면, 방향은 0, 2, 4, 6이 되고, 그렇지 않으면 1, 3, 5, 7이 된다.
 질량이 0인 파이어볼은 소멸되어 없어진다.
 */

/*
 <문제풀이>
 오래걸렸던 문제이다. -> 격자의 행과 열은 1번부터 N번까지 번호가 매겨져 있고, 1번 행은 N번과 연결되어 있고, 1번 열은 N번 열과 연결되어 있다.
 이 말을 안봐서 한참을 고생함
 
 1번 풀이 - 시간초과가 떳음
 
 func find() {
   for y in 0..<n {
     for x in 0..<n {
       if board[y][x] >= 2 {
         let tmp = fireballs.filter { $0.x == x && $0.y == y }
         tmp.forEach { tmpball in fireballs.removeAll(where: { ball in tmpball == ball })}
         let new = mixFireballs(balls: tmp)
         fireballs += mixFireballs(balls: tmp)
         board[y][x] = new.count
       }
     }
   }
 }
 이 부분에서 시간초과가 났었는데, board에서는 각 칸에 몇개있는지 확인하고, 해당 x,y 좌표를
 가지고 있는 fireball을 fireballs에서 찾는다. -> 여기서 일단 시간이 걸리는듯 했다.
 (N) * (N) * fireballs 갯수 * tmp 갯수
 
 2번 풀이
 위의 풀이가 아래로 변경되었다.
 func merge() {
   let tmplist = board.flatMap { $0}.filter { $0.count >= 2 }
   tmplist.forEach {
     let new = mixFireballs(balls: $0)
     board[$0.first!.y][$0.first!.x] = new
   }
   fireballs = board.flatMap {$0}.flatMap {$0}
 }
 flatmap함수는 배열의 차원수를 줄여준다. 그래서 fireball갯수가 2개 넘는것 찾고
 mix 해주고, board에 다시 넣어주기
 그리고 board의 차원수 2번 줄여줘서 fireballs에 넣어준다.
 */

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
