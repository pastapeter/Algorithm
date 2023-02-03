//
//  main.swift
//  정도현_0202
//
//  Created by Jung peter on 2/2/23.
//

import Foundation

enum Color: Int {
  case white = 0
  case red = 1
  case blue = 2
}

struct Command {
  var x: Int
  var y: Int
  var direction: Int
}

struct Horse {
  var order: Int
  var direction: Int
}

struct Content {
  var array: [Horse] = []
}

let NK = readLine()!.split(separator: " ").map { Int(String($0))!}
let N = NK[0]
let K = NK[1]
var board = [[Color]]()
var contentboard = [[Content]](repeating: [Content](repeating: Content(), count: N), count: N)
var commands = [Command]()

for _ in 0..<N {
  board.append(readLine()!.split(separator: " ").map { Color(rawValue:Int(String($0))!)!})
}

// y, x, direction
for i in 0..<K {
  let new = readLine()!.split(separator: " ").map { Int(String($0))! }
  commands.append(Command(x: new[1]-1, y: new[0]-1, direction: new[2]))
  let horse = Horse(order: i+1, direction: new[2])
  contentboard[new[0]-1][new[1]-1].array.append(horse)
}

func reverseDirection(_ direction: Int) -> Int {
  if direction == 1 {
    return 2
  } else if direction == 2 {
    return 1
  } else if direction == 3 {
    return 4
  } else {
    return 3
  }
}

func whenRed(i: Int, nx: Int, ny: Int, change: Bool) {
  if change == false {
    var old = contentboard[commands[i].y][commands[i].x].array
    let index = old.firstIndex(where: { $0.order == i+1})!
    let moving = contentboard[commands[i].y][commands[i].x].array[index...]
    contentboard[commands[i].y][commands[i].x].array.removeSubrange(index...)
    contentboard[ny][nx].array += Array(moving.reversed())
    contentboard[ny][nx].array.forEach {
      commands[$0.order-1] = Command(x: nx, y: ny, direction: $0.direction)
    }
  } else {
    var old = contentboard[commands[i].y][commands[i].x].array
    let index = old.firstIndex(where: { $0.order == i+1})!
    var moving = Array(contentboard[commands[i].y][commands[i].x].array[index...])
    moving[0].direction = reverseDirection(moving[0].direction)
    contentboard[commands[i].y][commands[i].x].array.removeSubrange(index...)
    contentboard[ny][nx].array += Array(moving.reversed())
    contentboard[ny][nx].array.forEach {
      commands[$0.order-1] = Command(x: nx, y: ny, direction: $0.direction)
    }
  }
  
}

func whenWhite(i: Int, nx: Int, ny: Int, change: Bool) {
  if change == false {
    var old = contentboard[commands[i].y][commands[i].x].array
    let index = old.firstIndex(where: { $0.order == i+1})!
    let moving = contentboard[commands[i].y][commands[i].x].array[index...]
    contentboard[commands[i].y][commands[i].x].array.removeSubrange(index...)
    contentboard[ny][nx].array += moving
    contentboard[ny][nx].array.forEach {
      commands[$0.order-1] = Command(x: nx, y: ny, direction: $0.direction)
    }
  } else {
    var old = contentboard[commands[i].y][commands[i].x].array
    let index = old.firstIndex(where: { $0.order == i+1})!
    var moving = Array(contentboard[commands[i].y][commands[i].x].array[index...])
    moving[0].direction = reverseDirection(moving[0].direction)
    contentboard[commands[i].y][commands[i].x].array.removeSubrange(index...)
    contentboard[ny][nx].array += moving
    contentboard[ny][nx].array.forEach {
      commands[$0.order-1] = Command(x: nx, y: ny, direction: $0.direction)
    }
  }
 
}

func solution() -> Int {
  
  var result = 0
  let dx = [0, 1, -1, 0, 0]
  let dy = [0, 0, 0, -1, 1]
  var turn = 0
  
  while turn <= 1000 {
    turn += 1
//    print(turn)
    for i in commands.indices {
      var nx = commands[i].x + dx[commands[i].direction]
      var ny = commands[i].y + dy[commands[i].direction]
      
      // 나가는거
      if nx < 0 || ny < 0 || nx >= N || ny >= N {
        var old = contentboard[commands[i].y][commands[i].x].array
        let index = old.firstIndex(where: { $0.order == i+1})!
        var new = contentboard[commands[i].y][commands[i].x].array[index]
        new.direction = reverseDirection(new.direction)
        nx = commands[i].x + dx[new.direction]
        ny = commands[i].y + dy[new.direction]
        if nx < 0 || ny < 0 || nx >= N || ny >= N {
          commands[i].direction = new.direction
        } else if board[ny][nx] == .blue {
          contentboard[commands[i].y][commands[i].x].array.remove(at: index)
          contentboard[commands[i].y][commands[i].x].array.append(new)
        } else if board[ny][nx] == .red {
          whenRed(i: i, nx: nx, ny: ny, change: true)
        } else {
          whenWhite(i: i, nx: nx, ny: ny, change: true)
        }
      } else if board[ny][nx] == .red {
        whenRed(i: i, nx: nx, ny:ny, change: false)
      } else if board[ny][nx] == .white {
        whenWhite(i: i, nx: nx, ny: ny, change: false)
      } else {
        var old = contentboard[commands[i].y][commands[i].x].array
        let index = old.firstIndex(where: { $0.order == i+1})!
        var new = contentboard[commands[i].y][commands[i].x].array.remove(at: index)
        new.direction = reverseDirection(new.direction)
        nx = commands[i].x + dx[new.direction]
        ny = commands[i].y + dy[new.direction]
        if nx < 0 || ny < 0 || nx >= N || ny >= N {
          contentboard[commands[i].y][commands[i].x].array.append(new)
        } else {
          contentboard[ny][nx].array.append(new)
          contentboard[ny][nx].array.forEach {
            commands[$0.order-1] = Command(x: nx, y: ny, direction: $0.direction)
          }
        }
        
      }
      
    }
//
//    for y in 0..<N {
//      for x in 0..<N {
//        print(contentboard[y][x], terminator: " ")
//      }
//      print("\n")
//    }
    
    for y in 0..<N {
      for x in 0..<N {
        contentboard[y][x].array.forEach {
          commands[$0.order-1] = Command(x: x, y: y, direction: $0.direction)
        }
        if contentboard[y][x].array.count == 4 {
          return turn}
      }
    }
    
  }
  
  if turn == 1001 { return -1}
  
  return result
}

print(solution())





