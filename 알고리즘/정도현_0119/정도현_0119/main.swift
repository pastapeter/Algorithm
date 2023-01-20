//
//  main.swift
//  정도현_0119
//
//  Created by Jung peter on 1/20/23.
//

import Foundation

let input = Int(readLine()!)!
// 0 ~ 9 값을 저장할 배열
var check = [Int](repeating: 0, count: 10)

func calc(n: Int, ten: Int) {
  var n = n
  while n > 0 {
    check[n%10] += ten
    n /= 10
  }
}

func solution(A: Int, B: Int, ten: Int) {
  var A = A
  var B = B
  // A를 ++하여서 0을 만들기
  while A % 10 != 0 && A<=B {
    // A를 ++할때는 calc를 거쳐야함
    calc(n: A, ten: ten)
    A += 1
  }
  if A > B { return }
  
  while B % 10 != 9 && A <= B {
    // A를 ++할때는 calc를 거쳐야함
    calc(n: B, ten: ten)
    B -= 1
  }
  
  var cnt = B/10 - A/10 + 1
  
  for i in 0..<10 {
    check[i] += cnt * ten
  }
  
  solution(A: A/10, B: B/10, ten: ten*10)
}

solution(A: 1, B: input, ten: 1)
check.forEach { print($0, terminator: " ")}






