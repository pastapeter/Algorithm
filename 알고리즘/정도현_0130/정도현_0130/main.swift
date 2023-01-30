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

var visitedMap = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)


var start: Coor = Coor(x: 0, y: N-1)


func solution() {
  visitedMap[start.y][start.x] = true
  print(dfs(start: start, score: planeMap[start.y][start.x], mode: .up, visited: visitedMap))
}

func dfs(start: Coor, score: Int, mode: Mode, visited: [[Bool]]) -> Int {
  
  var totalx = [0, 0, 1]
  var totaly = [-1, 1, 0]
  var score = score
  var visited = visited
  var new1 = 0
  var new2 = 0
  var new3 = 0
  
  if start == Coor(x: M-1, y: N-1) {
    return score
  }
  
  for i in 0..<3 {
    var nc = Coor(x: start.x + totalx[i], y: start.y + totaly[i])
    if nc.x < 0 || nc.x >= M || nc.y < 0 || nc.y >= N {
      continue
    }
    var ns = score + planeMap[nc.y][nc.x]
    if mode == .up {
      if (i == 0 || i == 2) && visited[nc.y][nc.x] == false { // mode가 같은데, 위로감
        visited[nc.y][nc.x] = true
        new1 = max(new1,dfs(start: nc, score: ns, mode: .up, visited: visited))
        visited[nc.y][nc.x] = false
      } else if i == 1 && visited[nc.y][nc.x] == false { //mode가 다르다
        visited[nc.y][nc.x] = true
        new2 = max(new2, dfs(start: nc, score: ns + planeMap[start.y][start.x], mode: .down, visited: visited))
        visited[nc.y][nc.x] = false
      }
    } else {
      if (i == 1 || i == 2) && visited[nc.y][nc.x] == false { //mode가 같다
        visited[nc.y][nc.x] = true
        new3 = max(new3, dfs(start: nc, score: ns, mode: .down, visited: visited))
        visited[nc.y][nc.x] = false
      } else if i == 0 && visited[nc.y][nc.x] == false {
        continue// mode가 다르다.
      }
    }
  }
  
  return max(new1, new2, new3)
}

solution()
