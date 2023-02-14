import Foundation

struct Coor: Hashable {
  var x: Int
  var y: Int
}

func bfs(start: Coor, board: inout [[String]]) -> Set<Coor> {
  var queue = [start]
  var visited: Set<Coor> = [start]
  board[start.y][start.x] = "-"
  var area: Set<Coor> = [start]
  let dx = [1, -1, 0, 0, 1, 1, -1 ,-1]
  let dy = [0, 0, 1, -1, 1, -1, 1, -1]
  
  while !queue.isEmpty {
    
    var now = queue.removeFirst()
    
    for i in 0..<8 {
      
      let nx = now.x + dx[i]
      let ny = now.y + dy[i]
      
      if nx < 0 || ny < 0 || nx >= board[0].count || ny >= board.count {
        continue
      }
      
      if !visited.contains(Coor(x: nx, y: ny)) && board[ny][nx] == "#" {
        queue.append(Coor(x: nx, y: ny))
        visited.insert(Coor(x: nx, y: ny))
        area.insert(Coor(x: nx, y: ny))
        board[ny][nx] = "-"
      }
    }
  }
  return area
}

var cnt = 0
func check(start: Coor, board: [[String]], coors: Set<Coor>, direction: Int) -> Bool {
  
  let dx = [1, -1, 0, 0]
  let dy = [0, 0, 1, -1]
  
  if start.x < 0 || start.y < 0 || start.x >= board[0].count || start.y >= board.count {
    return false
  }
  
  if coors.contains(start) {
    return true
  }
 
  let left = check(start: Coor(x: start.x + dx[direction], y: start.y + dy[direction]), board: board, coors: coors, direction: direction)
  return left
  
}

func solution(_ grid:[String]) -> Int {
    
  var board = [[String]]()
  
  for row in grid {
    board.append(row.map { String($0) })
  }
  
  var coors = [Set<Coor>]()
  
  for y in 0..<grid.count {
    for x in 0..<board[y].count {
      if board[y][x] == "#" {
        coors.append(bfs(start: Coor(x: x, y: y), board: &board))
      }
    }
  }
  
  
  var cnt = 0
  
  for coor in coors {
    cnt += coor.count
    for y in 0..<grid.count {
      for x in 0..<board[y].count {
        if board[y][x] == "." {
          let left = check(start: Coor(x: x, y: y), board: board, coors: coor, direction: 0)
          let right = check(start: Coor(x: x, y: y), board: board, coors: coor, direction: 1)
          let up = check(start: Coor(x: x, y: y), board: board, coors: coor, direction: 2)
          let down = check(start: Coor(x: x, y: y), board: board, coors: coor, direction: 3)
          if left && right && up && down {
            print(x, y)
            cnt += 1}
        }
      }
    }

  }
  
  return cnt
}


