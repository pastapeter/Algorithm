//
//  main.swift
//  ps1655
//
//  Created by Jung peter on 3/21/23.
//

/*
 백준이는 동생에게 "가운데를 말해요" 게임을 가르쳐주고 있다. 백준이가 정수를 하나씩 외칠때마다 동생은 지금까지 백준이가 말한 수 중에서 중간값을 말해야 한다. 만약, 그동안 백준이가 외친 수의 개수가 짝수개라면 중간에 있는 두 수 중에서 작은 수를 말해야 한다.

 예를 들어 백준이가 동생에게 1, 5, 2, 10, -99, 7, 5를 순서대로 외쳤다고 하면, 동생은 1, 1, 2, 2, 2, 2, 5를 차례대로 말해야 한다. 백준이가 외치는 수가 주어졌을 때, 동생이 말해야 하는 수를 구하는 프로그램을 작성하시오.*/

/*
 첫풀이
 arr에서 최대힙에서 최소힙에서 나온거 하나씩 빼주는 것!
 이것은 근데 ,, sort와 별차이 없을듯
 if arr.count == 1 {
   print(temp)
 } else if arr.count == 2 {
   print(arr.min()!)
 } else {
   while arr.count > 2 {
     let a = maxq.pop()!
     let b = minq.pop()!
     arr.remove(at: arr.firstIndex(of: a)!)
     arr.remove(at: arr.firstIndex(of: b)!)
   }
   if arr.count == 2 {
     print(arr.min()!)
   } else { print(arr.removeFirst())}
 }
 */

/*
 풀이
 2개의 우선순위 큐로 중앙값을 구할 수 있다.
 Maxqueue, Minqueue를 사용해서 Min queue에는 Max의 root보다 크게 만들면
 Max root 는 모든 Minqueue에 들어있는 숫자보다 작을 것이다.
 그렇게 만드려면
 Minqueue의 root와 max root를 비교해서 minroot보다 maxroot가 크면 둘이 바꿔준다.
 그러면 minqueue의 모든 값이 max queue의 모든 값보다 작아진다.
 이때, max queue에 값을 꺼낸다면, 중앙값을 구할 수 있다.
 */

import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

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
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
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
  
  mutating func sink(_ index: Int) {
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
  
  mutating func swim(_ index: Int) {
    var index = index
    while index > 0 && ordered(heap[(index - 1) / 2], heap[index]) {
      heap.swapAt((index - 1) / 2, index)
      index = (index - 1) / 2
    }
  }
}
let fileio = FileIO()
let n = fileio.readInt()
var ans: String = ""
var maxq = PriorityQueue<Int>(ascending: false)
var minq = PriorityQueue<Int>(ascending: true)
for i in 0..<n {
  let temp = fileio.readInt()
  if i%2 == 0 {
    maxq.push(temp)
  } else {
    minq.push(temp)
  }
  
  if minq.isEmpty {
    ans += "\(maxq.heap[0])\n"
    continue
  }
  
  let maxroot = maxq.heap.first!
  let minroot = minq.heap.first!
  
  if maxroot > minroot {
    minq.heap[0] = maxroot
    maxq.heap[0] = minroot
  }
  
  if i%2 == 0 {
    minq.sink(0)
  } else {
    maxq.sink(0)
  }
  
  ans += "\(maxq.heap.first!)\n"
}

print(ans)
