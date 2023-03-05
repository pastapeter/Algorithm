//
//  main.swift
//  ps3109
//
//  Created by Jung peter on 3/4/23.
//

import Foundation

/*
 유명한 제빵사 김원웅은 빵집을 운영하고 있다. 원웅이의 빵집은 글로벌 재정 위기를 피해가지 못했고, 결국 심각한 재정 위기에 빠졌다.

 원웅이는 지출을 줄이고자 여기저기 지출을 살펴보던 중에, 가스비가 제일 크다는 것을 알게되었다. 따라서 원웅이는 근처 빵집의 가스관에 몰래 파이프를 설치해 훔쳐서 사용하기로 했다.

 빵집이 있는 곳은 R*C 격자로 표현할 수 있다. 첫째 열은 근처 빵집의 가스관이고, 마지막 열은 원웅이의 빵집이다.

 원웅이는 가스관과 빵집을 연결하는 파이프를 설치하려고 한다. 빵집과 가스관 사이에는 건물이 있을 수도 있다. 건물이 있는 경우에는 파이프를 놓을 수 없다.

 가스관과 빵집을 연결하는 모든 파이프라인은 첫째 열에서 시작해야 하고, 마지막 열에서 끝나야 한다. 각 칸은 오른쪽, 오른쪽 위 대각선, 오른쪽 아래 대각선으로 연결할 수 있고, 각 칸의 중심끼리 연결하는 것이다.

 원웅이는 가스를 되도록 많이 훔치려고 한다. 따라서, 가스관과 빵집을 연결하는 파이프라인을 여러 개 설치할 것이다. 이 경로는 겹칠 수 없고, 서로 접할 수도 없다. 즉, 각 칸을 지나는 파이프는 하나이어야 한다.

 원웅이 빵집의 모습이 주어졌을 때, 원웅이가 설치할 수 있는 가스관과 빵집을 연결하는 파이프라인의 최대 개수를 구하는 프로그램을 작성하시오.
 */
/*
 문제 풀이
 
 읽자마자 백트래킹이 생각났다. 백트래킹이 생각났는데, 가스가 연결되면
 가스관은 계속 고정된다.
 처음에는 쭉갔다가 완성이 안되면 다시 가스관 걷어내야하는거 아닌가? 라는 생각을 하긴했다.
 근데 어차피 안되는 칸은 안되는 것이다. 왜냐면 해당 칸에서 갈수 있는 칸은 정해져있다. 그래서 만약에 그 칸을 걸쳐 갈 수 있더라도 1개만 될것이다.
 
 그리고 끝까지 갔을 때, 또 시작을 안하고 return 해야한다.
 if (complete!=ans) { return } 없으면 반복문 중간에 return으로 나오더라도 또 돌게되고, 그때 또 ans += 1이 돌 수 있다.
 더하면 안되는 이유는 해당 가스관이 일단 +1이되었다면, 어떤 가스관이더라도 그 칸을 걸치지 못하기 때문
 원래 Backtracking일때 시간복잡도: O(R*3^c)
 백트래킹하지말고 경로를 계속 check하는 것 O(R*C)
  
 */

let RC = readLine()!.split(separator: " ").map { Int(String($0))!}
let r = RC[0]
let c = RC[1]
var board = [[String]]()
var newboard = [[String]]()
for _ in 0..<r {
  let temp = readLine()!.map{String($0)}
  board.append(temp)
  newboard.append(temp)
}


let dx = [1,1,1]
let dy = [-1,0,1]
var ans = 0
var complete = 0

func inRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < c && y >= 0 && y < r
}

func backtracking(x: Int, y: Int) {
  
  complete = ans
  // 끝까지 갔으면 탈출하기
  if x == c-1 {
    ans += 1
    return
  }
  
  for i in 0..<3 {
   
    let nx = x + dx[i]
    let ny = y + dy[i]
    if inRange(nx, ny) && board[ny][nx] == "." {
      // 끝까지갔으면 탈출해야함
      if complete != ans { return }
      board[ny][nx] = "-"
      backtracking(x: nx, y: ny)
    }
  }
}

for i in 0..<r {
  backtracking(x: 0, y: i)
}

print(ans)
