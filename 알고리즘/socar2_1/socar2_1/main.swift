//
//  main.swift
//  socar2_1
//
//  Created by Jung peter on 3/7/23.
//

import Foundation

struct Coor {
  var x: Int
  var y: Int
}

struct Rectangle {
  var idx: Int
  var leftX: Int
  var rightX: Int
  var bottomY: Int
  var topY: Int
}

var visited: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: 1000001), count: 1000001)

func goDown(rects: [Rectangle]) -> [Rectangle] {
  
  var rs = rects
  for r in rs {
    var range = r.rightX - r.leftX
    
  }
  
  return rs
}


func solution(_ rectangles: [[Int]]) -> [String] {
  var rects: [Rectangle] = []
  var ans: [String] = []
  
  var idx = 0
  for rectangle in rectangles {
    rects.append(Rectangle(idx: idx, leftX: rectangle[0], rightX: rectangle[2], bottomY: rectangle[1], topY: rectangle[3]))
    idx += 1
  }
  
  var sortedByY = rects.sorted(by: { $0.bottomY < $1.bottomY})
  
  
  return ans
}
