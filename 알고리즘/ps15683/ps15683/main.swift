//
//  main.swift
//  ps15683
//
//  Created by Jung peter on 3/17/23.
//

import Foundation

/*
 문제 풀이
 1)
 처음에는 그리디로 들어갔다 -> 심지어 거의 대부분의 태케를 다 풀려짐
 5->4->3->2->1 로 가면 될 줄 았았음
 하지만 계속 17프로 오류
 진짜 여기서 어떻게든 고치려고했지만 시간만 낭비...
 
 2) 해답보고, 완전탐색이라는 것을 알게댐
 그래서 백트래킹으로 만나면 하나씩해보는것으로 하게되었음
 let dir = [[], [[0],[1], [2], [3]], [[0,1], [2,3]], [[0,2], [2,1], [1,3], [3,0]], [[3,0,2], [1,3,0], [0,2,1], [2,1,3]], [[0,1,2,3]]]
 이 부분은 방향설계부분인데, 각각 동서남북에 대한 방향index를 1,2,3,4,5에 설정해준것임
 N,M 은 둘다 8까지
 check함수 시간복잡도 O(N)
 dfs 시간복잡도는 O(4^(CCTV갯수))
 
 
 */

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]
let dx = [1,-1,0,0]
let dy = [0,0,1,-1]
// 방향 설계
let dir = [[], [[0],[1], [2], [3]], [[0,1], [2,3]], [[0,2], [2,1], [1,3], [3,0]], [[3,0,2], [1,3,0], [0,2,1], [2,1,3]], [[0,1,2,3]]]
var board: [[Int]] = []
var queue: [(Int, Int, Int)] = []
var cctvCnt = 0
var ans = Int.max
for y in 0..<n {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  board.append(temp)
}

for y in 0..<n {
  for x in 0..<m {
    if board[y][x] != 6 && board[y][x] != 0 {
      cctvCnt += 1
      queue.append((x, y, board[y][x]))
    }
  }
}

func inRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < m && y >= 0 && y < n && board[y][x] != 6
}

// Check함수는 해당 디렉션에서 끝까지 앞으로 가면서 -1로 바꿔주기
func check(start: (x: Int, y: Int), direction: [Int], tmp: inout [[Int]]) {
    for d in direction {
      var newcoor = start
      while true {
        newcoor.x += dx[d]
        newcoor.y += dy[d]
        if inRange(newcoor.x, newcoor.y) {
          if tmp[newcoor.y][newcoor.x] == 0 {
            tmp[newcoor.y][newcoor.x] = -1
          }
        } else { break }
      }
    }
}

// 백트래킹
func dfs(board: [[Int]], cnt: Int) {
  var newBoard = board
  if cnt == cctvCnt {
    var temp = 0
    for y in 0..<n {
      for x in 0..<m {
        if board[y][x] == 0 {
          temp += 1
        }
      }
    }
    ans = min(ans, temp)
    return
  }
  // 여기서 배운점은 queue를 사용해서 2차원 배열을 돌지 않아도 필요한 값을 빼서 쓸수 있다는 점
  
  var poped = queue[cnt]
  for i in dir[poped.2] {
    check(start: (poped.0, poped.1), direction: i, tmp: &newBoard)
    dfs(board: newBoard, cnt: cnt+1)
    newBoard = board
  }
}


dfs(board: board, cnt: 0)
print(ans)
