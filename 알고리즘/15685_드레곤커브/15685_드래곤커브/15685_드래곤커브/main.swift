//
//  main.swift
//  15685_드래곤커브
//
//  Created by abc on 2022/01/22.
//

import Foundation

let number = Int(readLine()!)!
var infoArr = [[Int]]()
for _ in 0..<number {
  infoArr.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

extension Array: Hashable { }

func solution(_ n: Int, _ arr: [[Int]]) -> Int {
  var answer = 0
  var smallestPoint = 0
  var biggestPoint = 0
  var firstPoint = [0,0]
  var pointSet = Set<Array<Int>>()
  var generation = 0
  for turn in 0..<n {
    var direction = [Int]()
    let turnArr = arr[turn]
    
    firstPoint[0] = turnArr[0]
    firstPoint[1] = turnArr[1]
    pointSet.insert(firstPoint)
    direction.append(turnArr[2])
    generation = turnArr[3]
    
    for _ in 0..<generation {
      var new = direction
      for i in new.indices {
        let index = direction.count - 1 - i
        new[i] = (direction[index] + 1) % 4
      }
      direction.append(contentsOf: new)
    }
    
    for direction in direction {
      switch direction {
      case 0:
        firstPoint = [firstPoint[0] + 1, firstPoint[1]]
        break
      case 1:
        firstPoint = [firstPoint[0], firstPoint[1] - 1]
        break
      case 2:
        firstPoint = [firstPoint[0] - 1, firstPoint[1]]
        break
      case 3:
        firstPoint = [firstPoint[0], firstPoint[1] + 1]
        break
      default:
        break
      }
      if smallestPoint > min(firstPoint[0], firstPoint[1]) {
        smallestPoint = min(firstPoint[0], firstPoint[1])
      }
      if biggestPoint < max(firstPoint[0], firstPoint[1]) {
        biggestPoint = max(firstPoint[0], firstPoint[1])
      }
      pointSet.insert(firstPoint)
    }
  }

  var row = [Int](repeating: -1, count: biggestPoint - smallestPoint + 3)
  var map = [[Int]](repeating: row, count: biggestPoint - smallestPoint + 3)
  
  for point in pointSet {
      map[point[1] - smallestPoint][point[0] - smallestPoint] = 1
  }
  for yindex in map.indices {
    for xindex in map[yindex].indices {
      if map[yindex][xindex] == 1 && map[yindex][xindex+1] == 1 && map[yindex+1][xindex] == 1 && map[yindex+1][xindex + 1] == 1 {
          answer += 1
      }
    }
  }
  
  return answer
}

print(solution(number, infoArr))
