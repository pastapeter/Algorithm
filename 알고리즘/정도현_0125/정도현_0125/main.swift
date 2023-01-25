//
//  main.swift
//  정도현_0125
//
//  Created by Jung peter on 1/25/23.
//

import Foundation

let n = Int(readLine()!)!

var liquids = readLine()!.split(separator: " ").map { Int(String($0))!}
var start = 0
var end = n-1
var answer: [Int] = [start, end]
var temp = abs(liquids[start] + liquids[end])
var result = abs(liquids[start] + liquids[end])

while start < end {
  
  if abs(liquids[start] + liquids[end]) == 0 {
    answer = [start, end]
    break
  }
  
  if abs(liquids[start+1] + liquids[end]) < abs(liquids[start] + liquids[end-1]) {
    start = start+1
    if start == end { break }
    temp = abs(liquids[start] + liquids[end])
    if temp < result {
      result = temp
      answer = [start ,end]
    }
  } else {
    end -= 1
    if start == end { break }
    temp = abs(liquids[start] + liquids[end])
    if temp < result {
      result = temp
      answer = [start ,end]
    }
  }
  
}


answer.forEach { print(liquids[$0], terminator: " ")}
