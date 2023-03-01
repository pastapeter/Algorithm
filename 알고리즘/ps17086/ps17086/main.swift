//
//  main.swift
//  ps17086
//
//  Created by Jung peter on 3/1/23.
//
/*
 N×M 크기의 공간에 아기 상어 여러 마리가 있다. 공간은 1×1 크기의 정사각형 칸으로 나누어져 있다. 한 칸에는 아기 상어가 최대 1마리 존재한다.

 어떤 칸의 안전 거리는 그 칸과 가장 거리가 가까운 아기 상어와의 거리이다. 두 칸의 거리는 하나의 칸에서 다른 칸으로 가기 위해서 지나야 하는 칸의 수이고, 이동은 인접한 8방향(대각선 포함)이 가능하다.

 안전 거리가 가장 큰 칸을 구해보자.
*/

/*
 되게 간단한 bfs이다. 근데 문제를 잘못읽었다... 어떤 칸의 안전거리는 그 칸과 가장 가까운 거리... 난 아기상어끼리 거리인줄,,
 bfs인데 8방향으로 돌리는 것!
 시간복잡도는 인접행렬에서 bfs의 시간 복잡도는 O(N*M)이다.
 8방향이던 4방향이던 어쨋든 모든 정점을 돌아야한다.
 */

import Foundation

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]
var board = [[Int]]()
for _ in 0..<n {
  board.append(readLine()!.split(separator: " ").map { Int(String($0))!})
}
var ans = 0
let dx = [0,0,1,-1,1,1,-1,-1]
let dy = [1,-1,0,0,-1,1,1,-1]

func isRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < m && y >= 0 && y < n
}

func safeDist(start: (x: Int, y: Int)) -> Int {
  var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)
  var newboard = [[Int]](repeating: [Int](repeating: 0, count: m), count: n)
  visited[start.y][start.x] = true
  var queue = [start]
  while !queue.isEmpty {
    
    let now = queue.removeFirst()
    
    for i in 0..<8 {
      
      let nx = now.x + dx[i]
      let ny = now.y + dy[i]
      
      if !isRange(nx, ny) {
        continue
      }
      
      if visited[ny][nx] == false {
        queue.append((nx, ny))
        visited[ny][nx] = true
        newboard[ny][nx] = newboard[now.y][now.x] + 1
        
        if board[ny][nx] == 1 {
            return newboard[ny][nx]
        }
      }
    }
  }
  return 0
}

for y in 0..<n {
  for x in 0..<m {
    if board[y][x] == 0 {
      ans = max(ans, safeDist(start: (x, y)))
    }
  }
}

print(ans)

