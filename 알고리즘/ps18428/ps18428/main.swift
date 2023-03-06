//
//  main.swift
//  ps18428
//
//  Created by Jung peter on 3/7/23.
//

/*
 <문제>
 N*N격자
 S = 학생
 T = 선생
 O = 장애물
 X = 길
 장애물을 3개 놓았을 때, 선생님의 감시를 피할수 있는가?
 선생님은 상하좌우로 볼 수 있음
 장애물 뒤에 숨어있는 학생은 볼 수없다.
 */

/*
 풀이
 선생님의 4방향으로 쭉 보았을때, 장애물이 있으면 False
 학생이 있으면 True로 하는 dfs함수를 만든다.
 장애물을 3개를 놓을 수 있는 공간은 조합을 사용하여,
 X의갯수C3으로 찾는다.
 백트래킹처럼, 3개 놓고, 되는지확인하고, 3개를 다시 뺀다.
 임의의3개공간에 장애물 3개 놓았을때, 1번이라도 학생을 발견하면, 다른 공간을 찾아야함
 */

/*
 시간복잡도
 O((N^2 - (T+S) C 3) * (T * 2N))
 */


import Foundation

struct Coor: Equatable {
  var x: Int
  var y: Int
}

func combi<T>(_ nums: [T], _ targetNum: Int) -> [[T]] {
  var result = [[T]]()
  
  func combination(_ index: Int, _ nowCombi: [T]) {
    if nowCombi.count == targetNum {
      result.append(nowCombi)
      return
    }
    
    for i in index..<nums.count {
      combination(i+1, nowCombi + [nums[i]])
    }
  }
  
  combination(0, [])
  return result
}

let n = Int(readLine()!)!
var board: [[String]] = []
for _ in 0..<n {
  let temp = readLine()!.split(separator: " ").map { String($0) }
  board.append(temp)
}
let dx = [1,-1,0,0]
let dy = [0,0,1,-1]
var students: [Coor] = []
var teachers: [Coor] = []
var roads: [Coor] = []
var obstacles: [[Coor]] = []

for y in 0..<n {
  for x in 0..<n {
    if board[y][x] == "S" { students.append(Coor(x: x, y: y))}
    else if board[y][x] == "T" {
      teachers.append(Coor(x: x, y: y))
    } else {
      roads.append(Coor(x: x, y: y))
    }
  }
}

// 조합으로 장애물을 놓을 수 있는 경우의 수 구하기
obstacles = combi(roads, 3)

func inRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < n && y >= 0 && y < n
}

//잡혔니?
func dfs(coor: Coor, dir: Int) -> Bool {
  
  // 다음칸을 구한다.
  let nx = coor.x + dx[dir]
  let ny = coor.y + dy[dir]
  
  // 다음칸으로 갈수 있다면?
  if inRange(nx, ny) {
    // 만약 S라면 학생 감시성공
    if board[ny][nx] == "S" {
      return true
      // 장애물이면 실패
    } else if board[ny][nx] == "O" {
      return false
    }
    // X면 다음칸에서 또 확인
    if board[ny][nx] == "X" {
      return dfs(coor: Coor(x: nx, y: ny), dir: dir)
    }
  }
  //갈 수없다면 return false
  return false
}

var ans = false
for obstacle in obstacles {
  
  // 장애물 설치
  for coor in obstacle {
    board[coor.y][coor.x] = "O"
  }
  
  ans = false
  for teacher in teachers {
    for i in 0..<4 {
      // 만약 걸렸다
      if dfs(coor: Coor(x: teacher.x, y: teacher.y), dir: i) == true {
        ans = true
        break
      }
    }
    if ans == true {break}
  }
  
  // 다 확인했는데 걸리지않았다면
  if ans == false {
    break
  }
  
  //장애물 제거
  for coor in obstacle {
    board[coor.y][coor.x] = "X"
  }
}

if ans == false {
  print("YES")
} else { print("NO")}
