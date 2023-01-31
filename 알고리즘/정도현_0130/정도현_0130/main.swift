//
//  main.swift
//  정도현_0130
//
//  Created by Jung peter on 1/30/23.
//

import Foundation

//일단 앞, 위, 아래 3가지 방향있음
// 상승비행일때는 위, 앞
// 하강비행일떄는 아래, 앞
// 처음에는 bfs인가 했다가, dfs로 backtracking 생각이 가장먼저 났는데, N이 너무 커서.. 동적프로그래밍인것같다는 생각이 들었음
// 지나간 칸은 다시 지나갈 수 없어

struct Coor: Hashable {
  var x: Int
  var y: Int
}

enum Mode {
  case up
  case down
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))!}
let N = NM[0]
let M = NM[1]
var planeMap: [[Int]] = []
var destination = Coor(x: M-1, y: N-1)
var result = Int.min

for y in 0..<N {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  planeMap.append(temp)
}

var start: Coor = Coor(x: 0, y: N-1)
func solution() {
  if N == 1 && M == 1 {
    print(planeMap[N-1][M-1] * 2)
  } else {
    print(dfs(start: start, score: planeMap[start.y][start.x], mode: .up))
  }
}

func dfs(start: Coor, score: Int, mode: Mode) -> Int {
  
  let totalx = [0, 0, 1]
  let totaly = [-1, 1, 0]
  let score = score
  var new1 = Int.min
  var new2 = Int.min
  var new3 = Int.min
  var new4 = Int.min
  var new5 = Int.min
  var new6 = Int.min
  
  if start == destination && mode == .down{
    return score
  }
  
  for i in 0..<3 {
    var nc = Coor(x: start.x + totalx[i], y: start.y + totaly[i])
    if nc.x < 0 || nc.x >= M || nc.y < 0 || nc.y >= N {
      continue
    }
    var ns = score + planeMap[nc.y][nc.x]
    
    if mode == .up {
      if i == 0 { // mode가 같은데, 위로감
        new1 = max(new1,dfs(start: nc, score: ns, mode: .up))
      } else if i == 1 { //mode가 다르다
        new2 = max(new2, dfs(start: nc, score: ns + planeMap[start.y][start.x], mode: .down))
      } else {
        new3 = max(new3, dfs(start: nc, score: ns, mode: .up))
        new4 = max(new4, dfs(start: nc, score: ns + planeMap[start.y][start.x], mode: .down))
      }
    } else {
      if i == 1 { //mode가 같
        new5 = max(new5, dfs(start: nc, score: ns, mode: .down))
      } else if i == 2 {
        new6 = max(new6, dfs(start: nc, score: ns, mode: .down))
      }
    }
  }
  
  return max(new1, new2, new3, new4, new5, new6)
}

solution()
