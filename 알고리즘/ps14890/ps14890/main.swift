//
//  main.swift
//  ps14890
//
//  Created by Jung peter on 3/13/23.
//

/*
 길을 지나갈 수 있으려면 길에 속한 모든 칸의 높이가 모두 같아야 한다. 또는, 경사로를 놓아서 지나갈 수 있는 길을 만들 수 있다. 경사로는 높이가 항상 1이며, 길이는 L이다. 또, 개수는 매우 많아 부족할 일이 없다. 경사로는 낮은 칸과 높은 칸을 연결하며, 아래와 같은 조건을 만족해야한다.

 경사로는 낮은 칸에 놓으며, L개의 연속된 칸에 경사로의 바닥이 모두 접해야 한다.
 낮은 칸과 높은 칸의 높이 차이는 1이어야 한다.
 경사로를 놓을 낮은 칸의 높이는 모두 같아야 하고, L개의 칸이 연속되어 있어야 한다.
 아래와 같은 경우에는 경사로를 놓을 수 없다.

 경사로를 놓은 곳에 또 경사로를 놓는 경우
 낮은 칸과 높은 칸의 높이 차이가 1이 아닌 경우
 낮은 지점의 칸의 높이가 모두 같지 않거나, L개가 연속되지 않은 경우
 경사로를 놓다가 범위를 벗어나는 경우
 */

/*
 시간 제한 2초 -> 2억
 가로(N) * 세로(N) * 비교시간(N) -> 100 * 100 * 100 -> 오케!
 */

/*
 처음에 많이 헤멧던 문제이다. 문제를 인식을 잘못한것같다.
 처음에는 좌 -> 우로 가면서 놓을 수 있는지 확인
 우 -> 좌로 가면서 놓을 수 있는지 확인하였음. 근데 경사로 방향도 체크를 헸으야하는데 이것을 체크하지 못함
 */
/*
 그 다음 사용한 방법은 한칸씩가면서, 현재와 전꺼를 체크한다.
 그리고 현재와 전꺼 체크했을때 차가 1일 경우, 그때는 이제 경사로를 놓을 수 있는지 확인한다.
 이때, 체크를 -1인지 ,1인지 체크를 해서 1면 크다는 뜻이니깐, 현위치에서 뒤로 체크를한다.
 -1이면 전꺼가 큰거니깐 앞에 경사로를 놔야하니깐 앞부분을 체크하면된다.
 */

import Foundation

let nl = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nl[0]
let l = nl[1]
var board: [[Int]] = []
var ans = 0

for _ in 0..<n {
  board.append(readLine()!.split(separator: " ").map { Int(String($0))!})
}

func check() {
  for y in 0..<n {
    if checkele(board: board[y]) { ans += 1}
  }
  
  for x in 0..<n {
    var temp: [Int] = []
    for y in 0..<n {
      temp.append(board[y][x])
    }
    if checkele(board: temp) { ans += 1}
  }
}


func checkele(board: [Int]) -> Bool {
  var used: [Bool] = [Bool](repeating: false, count: n)
  //한칸씩 가면서 본다.
  for x in 1..<n {
    // 차이가 1이상이면 일단 무조건 false
    if abs(board[x] - board[x-1]) > 1 {
      return false
    }
    // 현재가 전꺼보다 작다 내리막길 내어줘야함 앞에
    if board[x] < board[x-1] {
      for k in 0..<l {
        // 앞에 내리막길을 내어주니깐
        // 범위 벗어나거나, 이미 들어차있거나, 평평하지 않아서 경사로 놔주지 못하거나
        if x+k >= n || used[x+k] || board[x] != board[x+k] {
          return false
        }
        // 같으면 used에true 놔주는거임
        if board[x] == board[x+k] {
          used[x+k] = true
        }
      }
    } else if board[x] > board[x-1] {
      for k in 0..<l {
        if x-k-1 < 0 || used[x-k-1] || board[x-1] != board[x-k-1] {
          return false
        }
        if board[x-1] == board[x-k-1] {
          used[x-k-1] = true
        }
      }
    }
  }
  return true
}

check()
print(ans)

