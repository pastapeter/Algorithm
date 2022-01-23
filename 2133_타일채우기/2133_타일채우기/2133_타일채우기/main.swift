//
//  main.swift
//  2133_타일채우기
//
//  Created by abc on 2022/01/23.
//

import Foundation

let input = Int(readLine()!)!

func solution(_ n: Int) -> Int {
  var answer = 0
  var arr = [Int](repeating: 0, count: n+1)
  if n < 2 || n % 2 != 0 {return 0}
  else {
    arr[0] = 1
    for index in 2...n {
      if index % 2 == 0 {
        for i in stride(from: index - 2, through: 0, by: -2) {
          if i == index - 2 {
            arr[index] += arr[i] * 3
          } else {
            arr[index] += arr[i] * 2
          }
        }
      }
    }
  }
  answer = arr[n]
  return answer
}

print(solution(input))

