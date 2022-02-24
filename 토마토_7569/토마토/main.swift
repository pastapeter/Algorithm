import Foundation

let input = readLine()!.split(separator: " ").map { Int(String($0))!}
let M = input[0]
let N = input[1]
let H = input[2]
var flag = false
var map = [[Int]]()
var map3d = [[[Int]]]()

for height in 0..<H {
  map.removeAll()
  for y in 0..<N {
    map.append(readLine()!.split(separator: " ").map{ Int(String($0))!})
  }
  map3d.append(map)
}

var dx = [1, -1 ,0, 0, 0, 0]
var dy = [0, 0, 1, -1, 0, 0]
var dh = [0, 0, 0, 0, 1, -1]
var queue = [(Int, Int, Int)]()

for h in 0..<H {
  for y in 0..<N {
    for x in 0..<M {
      if flag == false && map3d[h][y][x] == 0 {
        flag = true
      }
      if map3d[h][y][x] == 1 {
        queue.append((x, y, h))
      }
    }
  }
}

var left = 0
var right = queue.count

func bfs(){
  while left < right {
    
    let tuple = queue[left]
    var x = tuple.0
    var y = tuple.1
    var h = tuple.2
    
    for i in 0..<6 {
      var nx = x + dx[i]
      var ny = y + dy[i]
      var nh = h + dh[i]
      
      if nx < 0 || ny < 0 || nx >= M || ny >= N || nh < 0 || nh >= H {
        continue
      }
      
      if map3d[nh][ny][nx] == 0 {
        map3d[nh][ny][nx] = map3d[h][y][x] + 1
        queue.append((nx, ny, nh))
        right += 1
      }
    }
    left += 1
  }
}

func findMax() -> Int{
  var maxInt = 0
  for h in 0..<H {
    for y in 0..<N {
      for x in 0..<M {
        if map3d[h][y][x] == 0 {
          return -1
        }
        maxInt = max(map3d[h][y][x], maxInt)
      }
    }
  }
  return maxInt-1
}

if flag == false {
  print(0)
} else {
  bfs()
  print(findMax())
}
