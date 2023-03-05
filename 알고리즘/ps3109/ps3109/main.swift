//
//  main.swift
//  ps3109
//
//  Created by Jung peter on 3/4/23.
//

import Foundation

final class FileIO {
    private let buffer: Data
    private var index: Int = 0
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        self.buffer = try! fileHandle.readToEnd()! // 인덱스 범위 넘어가는 것 방지
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer {
            index += 1
        }
        guard index < buffer.count else { return 0 }
        
        return buffer[index]
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1:-1)
    }


    @inline(__always) func readString() -> String {
            var str = ""
            var now = read()

            while now == 10
                    || now == 32 { now = read() } // 공백과 줄바꿈 무시

            while now != 10
                    && now != 32 && now != 0 {
                str += String(bytes: [now], encoding: .ascii)!
                now = read()
            }

            return str
        }
  }

//let file = FileIO()
//let (r, c) = (file.readInt(), file.readInt())
let RC = readLine()!.split(separator: " ").map { Int(String($0))!}
let r = RC[0]
let c = RC[1]
var board = [[String]]()
var newboard = [[String]]()
for _ in 0..<r {
//  var temp: [String] = []
//  for _ in 0..<c {
//    temp.append(file.readString())
//  }
  let temp = readLine()!.map{String($0)}
  board.append(temp)
  newboard.append(temp)
}


let dx = [1,1,1]
let dy = [-1,0,1]
var ans = 0
var complete = 0

func inRange(_ x: Int, _ y: Int) -> Bool {
  return x >= 0 && x < c && y >= 0 && y < r
}

func backtracking(x: Int, y: Int) {
  
  complete = ans
  if x == c-1 {
    ans += 1
    return
  }
  
  for i in 0..<3 {
   
    let nx = x + dx[i]
    let ny = y + dy[i]
    if inRange(nx, ny) && board[ny][nx] == "." {
      if complete != ans { return }
      board[ny][nx] = "-"
      backtracking(x: nx, y: ny)
    }
  }
}

for i in 0..<r {
  backtracking(x: 0, y: i)
}

print(ans)
