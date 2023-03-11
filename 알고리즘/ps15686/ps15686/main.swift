//
//  main.swift
//  ps15686
//
//  Created by Jung peter on 3/10/23.
//

/*
 풀이
 1(집)에서부터 2(치킨집)까지의 거리를 구하는것
 근데 2의 개수가 M개로 좁혀짐
 2의 개수 C M 으로 조합을 쓸 수 있음
 그리고 반복문으로 M개의 2위치 중 가장 작은것을 찾아서 더하기
 더한것 중에서 가장 작은 것이 정답
 */

/*
 시간복잡도
 O(2의개수Cm) * O(2N - M - 0의개수) * O(M)
 n이 50이고, 2의개수가 13일때
 100 - 13
 87 * m * 13*12*11*10*9 / m(m-1)m(m-3)..??()
 */

import Foundation

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

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]
var board = [[Int]]()
for _ in 0..<n {
  let temp = readLine()!.split(separator: " ").map{ Int(String($0))! }
  board.append(temp)
}

func dist(from a: (Int, Int), to b: (Int, Int)) -> Int {
  return abs(b.0 - a.0) + abs(b.1 - a.1)
}

var chickens: [(Int, Int)] = []
var houses: [(Int, Int)] = []

for y in 0..<n {
  for x in 0..<n {
    if board[y][x] == 2 {
      chickens.append((x, y))
    } else if board[y][x] == 1 {
      houses.append((x, y))
    }
  }
}

var chickenCombi = combi(chickens, m)
var ans = Int.max

for chickens in chickenCombi {
  var chickAns = 0
  for house in houses {
    var tempAns = Int.max
    for chicken in chickens {
      tempAns = min(tempAns, dist(from: house, to: chicken))
    }
    chickAns += tempAns
  }
  ans = min(ans, chickAns)
}

print(ans)
