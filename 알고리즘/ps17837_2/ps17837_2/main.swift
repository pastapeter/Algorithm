import Foundation
/*
 시간 복잡도
 O(1000 * K * 3)
 turn은 1000까지인데, 1turn시에 k개 말을 돌아야한다.
 해당 위치에서 말의 stack에서 해당 위치를 찾아야함.
 근데 모든 말에 4개전까지 있으니, 최대 3개까지가 최대일 것임
 */
struct Horse: Equatable, CustomStringConvertible {
  var description: String {
    var dirstr = ["->", "<-", "^", "v"]
    return "(\(id), \(dirstr[dir]))"
  }
  
  var id: Int
  var x: Int
  var y: Int
  var dir: Int
}

let nk = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nk[0]
let k = nk[1]
var board: [[Int]] = []
let dx = [1,-1,0,0]
let dy = [0,0,-1,1]

// 색상을 알 수 있음
for _ in 0..<n {
  let tmp = readLine()!.split(separator: " ").map { Int(String($0))!}
  board.append(tmp)
}
var horseBoard = [[[Horse]]](repeating: [[Horse]](repeating: [], count: n), count: n)
//행, 열의 번호, 이동 방향
var horseQueue: [Horse] = []
for i in 0..<k {
  let tmp = readLine()!.split(separator: " ").map { Int(String($0))!}
  let horse = Horse(id: i+1, x: tmp[1]-1, y: tmp[0]-1, dir: tmp[2]-1)
  horseQueue.append(horse)
  horseBoard[tmp[0]-1][tmp[1]-1].append(horse)
}

func isOverWith4() -> Bool {
  for y in 0..<n {
    for x in 0..<n {
      if horseBoard[y][x].count >= 4 {
        return true
      }
    }
  }
  return false
}

func inRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < n && y >= 0 && y < n
}

func reverseDir(_ dir: Int) -> Int {
  if dir == 0 { return 1 }
  if dir == 1 { return 0 }
  if dir == 2 { return 3 }
  if dir == 3 { return 2 }
  return 0
}

func OutOfRangeMove(from coorFrom: (x: Int, y: Int), id: Int) {
  let newdir = reverseDir(horseBoard[coorFrom.y][coorFrom.x].first(where: { $0.id == id })!.dir)
  let idx = horseBoard[coorFrom.y][coorFrom.x].firstIndex(where: { $0.id == id })!
  horseBoard[coorFrom.y][coorFrom.x][idx].dir = newdir
  // 새로운 곳
  var nx = coorFrom.x + dx[newdir]
  var ny = coorFrom.y + dy[newdir]
  // range안에있고, blue가 아니라면
  if inRange(nx, ny) && !(board[ny][nx] == 2) {
    // 하얀색
    if board[ny][nx] == 0 && !(board[ny][nx] == 2) {
      whiteMove(to: (nx, ny), from: (coorFrom.x, coorFrom.y), id: id)
    } else if board[ny][nx] == 1 {
      redMove(to: (nx, ny), from: (coorFrom.x, coorFrom.y), id: id)
    }
    
  }
}

func blueMove(to coorTo: (x: Int, y: Int), from coorFrom: (x: Int, y: Int), id: Int) {
  // coorTo로 가려했지만 없음 파란색임
  let newdir = reverseDir(horseBoard[coorFrom.y][coorFrom.x].first(where: { $0.id == id })!.dir)
  let idx = horseBoard[coorFrom.y][coorFrom.x].firstIndex(where: { $0.id == id })!
  horseBoard[coorFrom.y][coorFrom.x][idx].dir = newdir
  // 새로운 곳
  var nx = coorFrom.x + dx[newdir]
  var ny = coorFrom.y + dy[newdir]
  // range안에있고, blue가 아니라면
  if inRange(nx, ny) && !(board[ny][nx] == 2) {
    // 하얀색
    if board[ny][nx] == 0 {
      whiteMove(to: (nx, ny), from: (coorFrom.x, coorFrom.y), id: id)
    } else if board[ny][nx] == 1 {
      redMove(to: (nx, ny), from: (coorFrom.x, coorFrom.y), id: id)
    }
    
  }
}

func whiteMove(to coorTo: (x: Int, y: Int), from coorFrom: (x: Int, y: Int), id: Int) {
  let idx = horseBoard[coorFrom.y][coorFrom.x].firstIndex(where: { $0.id == id })!
  var temp = Array(horseBoard[coorFrom.y][coorFrom.x][idx...])
  for i in temp.indices {
    temp[i].x = coorTo.x
    temp[i].y = coorTo.y
  }
  horseBoard[coorFrom.y][coorFrom.x] = Array(horseBoard[coorFrom.y][coorFrom.x][..<idx])
  horseBoard[coorTo.y][coorTo.x] += temp
}

func redMove(to coorTo: (x: Int, y: Int), from coorFrom: (x: Int, y: Int), id: Int) {
  let idx = horseBoard[coorFrom.y][coorFrom.x].firstIndex(where: { $0.id == id })!
  var temp = Array(horseBoard[coorFrom.y][coorFrom.x][idx...])
  for i in temp.indices {
    temp[i].x = coorTo.x
    temp[i].y = coorTo.y
  }
  horseBoard[coorFrom.y][coorFrom.x] = Array(horseBoard[coorFrom.y][coorFrom.x][..<idx])
  horseBoard[coorTo.y][coorTo.x] += temp.reversed()
}


func move(to coorTo: (x: Int, y: Int), from coorFrom: (x: Int, y: Int), id: Int) -> Bool {
  // inrange 체크
  if inRange(coorTo.x, coorTo.y) {
    if board[coorTo.y][coorTo.x] == 0 { //하얀색
      whiteMove(to: coorTo, from: coorFrom, id: id)
    } else if board[coorTo.y][coorTo.x] == 1 {
      redMove(to: coorTo, from: coorFrom, id: id)
    } else {
      blueMove(to: coorTo, from: coorFrom, id: id)
    }
  } else {
    OutOfRangeMove(from: coorFrom, id: id)
  }
  
  // 1차원 베열을 사용해서 다음 Move를 check하니깐, 움직인 것에 대해서 3차원 배열을
  // 1차원 배열로 변경하고, 그리고 id를 기반으로 sort를 돌린다.
  horseQueue = horseBoard.flatMap {$0}.flatMap {$0}.sorted(by: { $0.id < $1.id})
  return isOverWith4()
  
}

func solve() -> Int {
  var turn = 0
  var index = 0
  while true {
    // 종료조건1
    if turn > 1000 {
      return -1
    }
    
    turn += 1
    for index in 0..<k {
      let poped = horseQueue[index]
      let popedDir = poped.dir
      var nx = poped.x + dx[popedDir]
      var ny = poped.y + dy[popedDir]
      if move(to: (nx, ny), from: (poped.x, poped.y), id: poped.id) {
        return turn
      }
    }

  }
}

print(solve())

