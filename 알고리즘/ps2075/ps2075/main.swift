//
//  main.swift
//  ps2075
//
//  Created by Jung peter on 3/3/23.
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

struct Node: Comparable {
  static func < (lhs: Node, rhs: Node) -> Bool {
    lhs.priority < rhs.priority
  }
  var node: Int = 0
  var priority: Int = 0
}

public struct PriorityQueue<T: Comparable> {
  fileprivate var heap = [T]()
  private let ordered: (T, T) -> Bool
  public init(ascending: Bool = false, startingValues: [T] = []) {
    ordered = ascending == true ? { $0 > $1 } : { $0 < $1 }
    
    heap = startingValues
    var i = heap.count/2 - 1
    while i >= 0 {
      sink(i)
      i -= 1
    }
  }
  
  public var count: Int { return heap.count }
  
  public var isEmpty: Bool {return heap.isEmpty}
  
  
  /// 우선순위에 큐 추가
  /// - Parameter element: 해당 요소는 우선순위 큐에 삽입되어야함
  public mutating func push(_ element: T) {
    heap.append(element)
    swim(heap.count - 1)
  }
  
  public mutating func pop() -> T? {
    if heap.isEmpty {return nil}
    if heap.count == 1 {
      return heap.removeFirst()
    }
    heap.swapAt(0, heap.count - 1)
    let temp = heap.removeLast()
    sink(0)
    return temp
  }
  
  public mutating func remove(_ item: T) {
    if let index = heap.firstIndex(of: item) {
      heap.swapAt(index, heap.count - 1)
      heap.removeLast()
      swim(index)
      sink(index)
    }
  }
  
  private mutating func sink(_ index: Int) {
    var index = index
    while 2*index + 1 < heap.count {
      var j = 2 * index + 1
      if j < heap.count - 1 && ordered(heap[j], heap[j+1]) {
        j += 1
      }
      if !ordered(heap[index], heap[j]) {break}
      heap.swapAt(index, j)
      index = j
    }
  }
  
  private mutating func swim(_ index: Int) {
    var index = index
    while index > 0 && ordered(heap[(index - 1) / 2], heap[index]) {
      heap.swapAt((index - 1) / 2, index)
      index = (index - 1) / 2
    }
  }
}

let file = FileIO()
let n = file.readInt()
//let n = Int(readLine()!)!
var pq = PriorityQueue<Int>(ascending: false)
for _ in 0..<n {
  let temp = file.readString().split(separator: " ").map { Int(String($0))! }
//  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  temp.forEach {
    pq.push($0)
  }
}
var ans = 0
for i in 0..<n {
  ans = pq.pop()!
}
print(ans)
