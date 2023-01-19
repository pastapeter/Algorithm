//
//  main.swift
//  정도현_0118
//
//  Created by Jung peter on 1/20/23.
//

import Foundation

let input = Int(readLine()!)!
var tornado = [[Int]]()
var tornadoInterval = 1
var start: (x: Int, y: Int) = (input/2,input/2)

for _ in 0..<input {
  var row = readLine()!.split(separator: " ").map { Int(String($0))!}
  tornado.append(row)
}

func outofMap(x: Int, y: Int) -> Bool {
  return x < 0 || y < 0 || x >= input || y >= input
}

let tx = [0, 0, 1, 1, 0, 0, -1, -1, -2, -1]
let ty = [1, -1, 1, -1, 2, -2, 1, -1, 0, 0]
let percent = [0.07, 0.07, 0.01, 0.01, 0.02, 0.02, 0.1, 0.1, 0.05, 0]
var result = 0

while !(start.x == 0 && start.y == 0) {
  
  
  let dx = [-1, 0, 1, 0]
  let dy = [0, 1, 0, -1]
  
  //방향으로
  for i in 0..<4 {
    //몇번갈거냐
    for _ in 0..<tornadoInterval {
      if start.x == 0 && start.y == 0 { break }
      
      start.x += dx[i]
      start.y += dy[i]
      var tempsand = 0
      
      // 모레가 있다면
      if tornado[start.y][start.x] > 0 {
        
        if i == 0 {
          for j in tx.indices {
            if floor(Double(tornado[start.y][start.x]) * percent[j]) > 0 {
              if outofMap(x: start.x + tx[j], y: start.y + ty[j]) {
                result +=  Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
              } else {
                tornado[start.y + ty[j]][start.x + tx[j]] += Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
              }
              tempsand += Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
            }
          }
          if outofMap(x: start.x + tx[tx.count-1], y: start.y + ty[tx.count-1]) {
            result += tornado[start.y][start.x] - tempsand
          } else {
            tornado[start.y + ty[tx.count-1]][start.x + tx[tx.count-1]] += tornado[start.y][start.x] - tempsand
            }
          tempsand = 0
        } else if i == 1 {
          // 아래는 y, x바꾸고 -처리
          for j in tx.indices {
            if floor(Double(tornado[start.y][start.x]) * percent[j]) > 0 {
              if outofMap(x: start.x - ty[j], y: start.y - tx[j]) {
                result +=  Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
              } else {
                tornado[start.y - tx[j]][start.x - ty[j]] += Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
              }
              tempsand += Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
            }
          }
          if outofMap(x: start.x - ty[tx.count-1], y: start.y - tx[tx.count-1]) {
            result += tornado[start.y][start.x] - tempsand
          } else {
            tornado[start.y - tx[tx.count-1]][start.x - ty[tx.count-1]] += tornado[start.y][start.x] - tempsand
          }
          tempsand = 0
        } else if i == 2 {
          // x, y그대로 - 처리
          for j in tx.indices {
            if floor(Double(tornado[start.y][start.x]) * percent[j]) > 0 {
              if outofMap(x: start.x - tx[j], y: start.y - ty[j]) {
                result +=  Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
              } else {
                tornado[start.y - ty[j]][start.x - tx[j]] += Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
              }
              tempsand += Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
            }
          }
          if outofMap(x: start.x - tx[tx.count-1], y: start.y - ty[tx.count-1]) {
            result += tornado[start.y][start.x] - tempsand
          } else {
            tornado[start.y - ty[tx.count-1]][start.x - tx[tx.count-1]] += tornado[start.y][start.x] - tempsand
          }
          tempsand = 0
        } else {
          // y, x 바꾸고 처리
          for j in tx.indices {
            if floor(Double(tornado[start.y][start.x]) * percent[j]) > 0 {
              if outofMap(x: start.x + ty[j], y: start.y + tx[j]) {
                result +=  Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
              } else {
                tornado[start.y + tx[j]][start.x + ty[j]] += Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
              }
              tempsand += Int(floor(Double(tornado[start.y][start.x]) * percent[j]))
            }
          }
          if outofMap(x: start.x + ty[tx.count-1], y: start.y + tx[tx.count-1]) {
            result += tornado[start.y][start.x] - tempsand
          } else {
            tornado[start.y + tx[tx.count-1]][start.x + ty[tx.count-1]] += tornado[start.y][start.x] - tempsand
          }
          tempsand = 0
        }
      }
      tornado[start.y][start.x] = 0
    }
    if i % 2 == 1 {
      tornadoInterval += 1
    }
  }
}

print(result)
