//
//  main.swift
//  ps20055
//
//  Created by Jung peter on 2/9/23.
//

import Foundation

let nk = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nk[0]
let k = nk[1]

var capa = readLine()!.split(separator: " ").map { Int(String($0))!}
var belt = [Bool](repeating: false, count: 2*n)

// 사실 로봇이 하나만 올라간다고 생각하고 풀었음 근데, 문제상에는 하나씩 올린다고 해지 하나만 올라갈수 있다는 말이 없는 듯함.
func loadRobot(in belt: inout [Bool], with capa: inout [Int]) {
  if belt[0] == false && capa[0] >= 1 {
    belt[0] = true
    capa[0] -= 1
  }
}

// 벨트가 움직일때는 벨트 위의 로봇도 같이 올라감
func move(in belt: inout [Bool], with capa: inout [Int]) {
  let lastEle = belt.removeLast()
  belt.insert(lastEle, at: 0)
  let lastEleInCapa = capa.removeLast()
  capa.insert(lastEleInCapa, at: 0)
}

// 원형 버퍼라서 다시 0으로 바꿔줘야함
func next(index: Int) -> Int {
  if index == 2*n-1 {
    return 0
  } else {
    return index+1
  }
}

// 로봇이 움직일때 먼저 들어온 순서이기 때문에 for를 역순으로 돌려야 함
func moveRobot(in belt: inout [Bool], with capa: inout [Int]) {
  for i in belt.indices.reversed() {
      if belt[i] == true && belt[next(index: i)] == false && capa[next(index: i)] >= 1 {
        belt[i] = false
        belt[next(index: i)] = true
        capa[next(index: i)] -= 1
      }
  }
}

// 내려야하는 곳에 로봇이 있을때는 내려야함
func dropRobot(in belt: inout [Bool], with capa: inout [Int]) {
  if belt[n-1] == true {
    belt[n-1] = false
  }
}

func solve() {
  
  var turn = 0
  while capa.filter { $0 == 0 }.count < k {
    
    turn += 1
    //움직이고
    move(in: &belt, with: &capa)
    // 하역장에 로봇있음?
    dropRobot(in: &belt, with: &capa)
    // 움직이고
    moveRobot(in: &belt, with: &capa)
    // 하역장에 로봇있음?
    dropRobot(in: &belt, with: &capa)
    // 로봇 올리고
    loadRobot(in: &belt, with: &capa)
    
  }
  
  print(turn)
  
}

solve()

