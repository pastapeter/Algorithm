//
//  main.swift
//  17142 연구소3
//
//  Created by abc on 2022/02/10.
//

import Foundation

var input = readLine()!.split(separator: " ").map{ Int(String($0))!}
let N = input[0]
let M = input[1]
var virsusLocationList: [(x: Int, y: Int)] = []
var combinationList: [[(x: Int, y: Int)]] = []
var matrix = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
var resultlist = [Int]()

func solution() {
  // matrix 만들기
  for i in 0..<N {
    let line = readLine()!.split(separator: " ").map{Int(String($0))!}
    for j in 0..<N {
      matrix[i][j] = line[j]
      if matrix[i][j] == 2 {
        virsusLocationList.append((x: j, y: i))
      }
    }
  }
  
  if !matrix.contains(where: { $0.contains(0)}) {
    print("0")
    return
  }
  
  //조합
  combinationList = combi(virsusLocationList, M)
  
  //맵그리기
  for combination in combinationList {
    var zeroCount = 0
    var finalMatrix = [[Int]](repeating: [Int](repeating: 100000, count: N), count: N)
    // 맵을 그렸어
    for y in 0..<N {
      for x in 0..<N {
        if matrix[y][x] == 1 {
          matrix[y][x] = -20
        } else if matrix[y][x] == 2 {
          let tempCoor = (x: x, y: y)
          if combination.contains(where: {
            $0.x == tempCoor.x && $0.y == tempCoor.y
          }) {
            matrix[y][x] = 2
          } else{
            matrix[y][x] = -10
          }
        } else if matrix[y][x] == 0 {
          zeroCount += 1
        }
      }
    }
    
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]
    
    //bfs
    var queue = [(x: Int, y: Int)]()
    for (index) in combination.indices{
      var newmatrix = matrix
      let start = combination[index]
      newmatrix[start.y][start.x] = 0
      queue.append((x: start.x, y: start.y))
      while !queue.isEmpty {
        let coor = queue.removeFirst()
        let x = coor.x
        let y = coor.y
        
        for i in 0..<4 {
          let nx = x + dx[i]
          let ny = y + dy[i]
          
          if nx < 0 || ny < 0 || nx > N-1 || ny > N-1 {
            continue
          }
          
          // 벽, 비활성화, 활성화인데 출발을 안한것
          if newmatrix[ny][nx] == -20 || newmatrix[ny][nx] == 2 { //벽이나 비활성화
            continue
          }
          
          
          // 0일 경우만
          if newmatrix[ny][nx] == 0 || newmatrix[ny][nx] == -10 {
            newmatrix[ny][nx] = newmatrix[y][x] + 1
            queue.append((x: nx, y: ny))
          }
        }
        
      }
      
      //3개 돌린 것 중에서 최소값만 넣기
      for y in 0..<N {
        for x in 0..<N {
          // 0이 빈칸이니깐 빈칸에는 10000을 넣고, 빈칸이 아닐경우 가장 작은 숫자
          if newmatrix[y][x] != 0 {
            finalMatrix[y][x] = min(finalMatrix[y][x], newmatrix[y][x])
          }
        }
      }
    }
    
    for i in combinationList {
      for j in i {
        finalMatrix[j.y][j.x] = 0
      }
    }

    // 속도 구하기
    var maxInt = 0
    for y in 0..<N {
      for x in 0..<N {
        maxInt = max(finalMatrix[y][x], maxInt)
      }
    }
    resultlist.append(maxInt)
  }
  
  print(resultlist.min()! == 100000 ? -1 : resultlist.min()!)
  
}

func combi(_ tuples: [(x: Int, y: Int)], _ targetNum: Int) -> [[(x: Int, y: Int)]] {
  var cases: [[(x: Int, y: Int)]] = []
  func combination(_ index: Int, _ nowCombi: [(x: Int, y: Int)]) {
    if nowCombi.count == targetNum {
      cases.append(nowCombi)
      return
    }
    for i in index..<tuples.count {
      combination(i+1, nowCombi + [tuples[i]])
    }
  }
  combination(0, [])
  return cases
}

solution()







