//
//  main.swift
//  ps10830
//
//  Created by Jung peter on 2/10/23.
//

import Foundation

let nb = readLine()!.split(separator: " ").map { Int(String($0))!}

let n = nb[0]
let b = nb[1]
var matrix: [[Int]] = []
for _ in 0..<n {
  matrix.append(readLine()!.split(separator: " ").map { Int(String($0))!})
}

func calculate(m1: [[Int]], m2: [[Int]]) -> [[Int]] {
  var result = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
  for y in 0..<n {
    for x in 0..<n {
        
      let row = m1[y]
      var col: [Int] = []
      for i in 0..<n {
        col.append(m2[i][x])
      }
      
      result[y][x] = zip(row, col).reduce(0) { $0 + ($1.0*$1.1)%1000}
    }
  }
  return result
}

func devideConquer(_ b: Int) -> [[Int]] {
  let height = Int(log2(Double(b)))
  if height == 0 {
    return matrix
  }
  var temp: [[Int]] = matrix
  for i in 0..<height {
    temp = calculate(m1: temp, m2: temp)
  }
  var newb = b - Int(pow(Double(2), Double(height)))
  if newb > 0 {
    var temp2 = devideConquer(newb)
    return calculate(m1: temp, m2: temp2)
  } else {
    return temp
  }
}

func solve() {
  
  let result = devideConquer(b)
  for y in 0..<n {
    for x in 0..<n {
      print(result[y][x]%1000, terminator: " ")
    }
    print("")
  }
  
}

solve()
