//
//  main.swift
//  ps10942
//
//  Created by Jung peter on 3/4/23.
//

import Foundation

final class FileIO {
    private var buffer:[UInt8]
    private var index: Int
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        index = 0
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        
        return buffer.withUnsafeBufferPointer { $0[index] }
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45{ isPositive.toggle(); now = read() } // 음수 처리
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

let file = FileIO()
//let n = Int(readLine()!)!
let n = file.readInt()
//var nums = readLine()!.split(separator: " ").map { Int(String($0))!}
var nums: [Int] = [0]
for _ in 0..<n {
  nums.append(file.readInt())
}
//let m = Int(readLine()!)!
let m = file.readInt()
var dp = [[Int]](repeating: [Int](repeating: 0, count: n+1), count: n+1)

for x in 1...n {
  dp[1][x] = 1
}

for x in 1..<n {
  if nums[x+1] == nums[x] {
    dp[2][x+1] = 1
  }
}

for y in 3...n {
  for x in y...n {
    if nums[x-y+1] == nums[x] && dp[y-2][x-1] == 1 {
      dp[y][x] = 1
    }
  }
}

var ans =  ""
for _ in 0..<m {
  let (S,E) = (file.readInt(), file.readInt())
  ans += "\(dp[E-S+1][E])\n"
}
print(ans)
