//
//  main.swift
//  정도현_0208
//
//  Created by Jung peter on 2/8/23.
//

import Foundation

struct Info {
  var studentID: Int
  var studentLikeIDs: [Int]
}

struct Coor: Hashable {
  var x: Int
  var y: Int
}

let n = Int(readLine()!)!
var studentInfos = [Info]()
var board = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)

func adjacentCell(cur: Coor) -> [Coor] {
  
  let dx = [-1, 1, 0, 0]
  let dy = [0, 0, -1, 1]
  var result: [Coor] = []
  
  for i in 0..<4 {
    
    let nx = cur.x + dx[i]
    let ny = cur.y + dy[i]
    
    if nx < 0 || ny < 0 || nx >= n || ny >= n {
      continue
    }
    
    result.append(Coor(x: nx, y: ny))
    
  }
  
  return result
}

func isEmpty(coor: Coor) -> Bool {
  return board[coor.y][coor.x] == 0
}

func findcellsForFirstCondition(cur: Coor, likes: [Int]) -> Int {
  var result = [(Coor, Int)]()
  let adjacentCells = adjacentCell(cur: cur)
  var cnt = 0
  for cell in adjacentCells {
    if likes.contains(board[cell.y][cell.x]) {
      cnt += 1
    }
  }
  return cnt
}

func findCellForSecondCondition(candidates: [Coor:Int]) -> [Coor] {
  var new: [Coor: Int] = [:]
  for candidate in candidates {
    new.updateValue(adjacentCell(cur: candidate.key).filter { isEmpty(coor: $0) }.count, forKey: candidate.key)
  }
  var maxCellCount = new.max { $0.value < $1.value }!.value
  new = new.filter { $0.value == maxCellCount }
  return Array(new.keys)
}

func leastNumOfRowAndCol(cells: [Coor]) -> Coor {
  let sorted = cells.sorted(by: {
    if $0.y < $1.y {
      return true
    } else if $0.y == $1.y {
      return $0.x < $1.x
    } else {
      return false
    }
  })
  return sorted.first!
}

for _ in 0..<(n*n) {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  studentInfos.append(Info(studentID: temp[0], studentLikeIDs: Array(temp[0...])))
}

for studentInfo in studentInfos {
  let turn = studentInfo.studentID
  var candidateCells: [Coor:Int] = [:]
  for y in 0..<n {
    for x in 0..<n {
      if isEmpty(coor: Coor(x: x, y: y)) {
        candidateCells.updateValue(findcellsForFirstCondition(cur: Coor(x: x, y: y), likes: studentInfo.studentLikeIDs), forKey: Coor(x: x, y: y))
      }
    }
  }
  let maxCellCount = candidateCells.max { $0.value < $1.value }!.value
  candidateCells = candidateCells.filter { $0.value == maxCellCount }
  let cells = findCellForSecondCondition(candidates: candidateCells)
  let finalCell = leastNumOfRowAndCol(cells: cells)
  board[finalCell.y][finalCell.x] = turn
}

var score = 0
for y in 0..<n {
  for x in 0..<n {
    let cell = board[y][x]
    var likes = adjacentCell(cur: Coor(x: x, y: y)).map { return board[$0.y][$0.x]}
    let idx = studentInfos.firstIndex(where: { $0.studentID == cell})!
    let samecount = Set(studentInfos[idx].studentLikeIDs).intersection(Set(likes)).count
    score += Int(pow(Double(10), Double(samecount-1)))
  }
}

print(score)
