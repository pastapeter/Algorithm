//
//  main.swift
//  socar2
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
  var coors: [Coor] = []
  
  init(idx: Int, leftX: Int, rightX: Int, bottomY: Int, topY: Int) {
    self.idx = idx
    self.leftX = leftX
    self.rightX = rightX
    self.bottomY = bottomY
    self.topY = topY
    for y in bottomY..<topY {
      for x in leftX..<rightX {
        coors.append(Coor(x: x, y: y))
        boards[y][x] = true
      }
    }
  }
}

var boards: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: 1000001), count: 1000001)

// NlogN
func sortByY(rects: [Rectangle]) -> [Rectangle] {
  return rects.sorted(by: { $0.bottomY < $1.bottomY })
}

//NlogN
func sortByX(rects: [Rectangle]) -> [Rectangle] {
  return rects.sorted(by: { $0.leftX < $1.leftX })
}

func inRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < 1000001 && y >= 0 && y < 1000001
}

func goDown(r: inout Rectangle) {
  let dir = (x: 0, y: -1)
  r.coors.sort(by: { $0.y < $1.y })
  // 10만
  for coor in r.coors {
    boards[coor.y][coor.x] = false
  }
  var cnt = 0
  var x = r.coors.first!.x
  var y = r.coors.first!.y
  while true {
    let ny = y + dir.y
    let nx = x + dir.x
    if !inRange(nx, ny) || boards[ny][nx] == true {
      break
    }
    x = nx
    y = ny
    cnt += 1
  }
  r.bottomY -= cnt
  r.topY -= cnt
  for i in r.coors.indices {
    r.coors[i].y -= cnt
  }
  for coor in r.coors {
    boards[coor.y][coor.x] = true
  }
}

func goLeft(r: inout Rectangle) {
  let dir = (x: -1, y: 0)
  r.coors.sort(by: { $0.x < $1.x })
  for coor in r.coors {
    boards[coor.y][coor.x] = false
  }
  var cnt = 0
  var x = r.coors.first!.x
  var y = r.coors.first!.y
  while true {
    let ny = y + dir.y
    let nx = x + dir.x
    if !inRange(nx, ny) || boards[ny][nx] == true {
      break
    }
    x = nx
    y = ny
    cnt += 1
  }
  r.leftX -= cnt
  r.rightX -= cnt
  for i in r.coors.indices {
    r.coors[i].x -= cnt
  }
  for coor in r.coors {
    boards[coor.y][coor.x] = true
  }
}

func solution(_ rectangles: [[Int]]) -> [String] {
  
  var rects: [Rectangle] = []
  var ans: [String] = []
  
  var idx = 0
  for rectangle in rectangles {
    rects.append(Rectangle(idx: idx, leftX: rectangle[0], rightX: rectangle[2], bottomY: rectangle[1], topY: rectangle[3]))
    idx += 1
  }
  var sortedRects = sortByY(rects: rects)
  for i in sortedRects.indices {
    goDown(r: &sortedRects[i])
  }
  
  sortedRects = sortByX(rects: sortedRects)
  for i in sortedRects.indices {
    goLeft(r: &sortedRects[i])
  }
  
  for r in sortedRects.sorted(by: { $0.idx < $1.idx }) {
    ans.append("\(r.leftX) \(r.bottomY) \(r.rightX) \(r.topY)")
  }
  
  return ans
}



