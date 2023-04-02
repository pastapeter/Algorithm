//
//  main.swift
//  ps1766
//
//  Created by Jung peter on 4/2/23.
//

import Foundation

/*
 1번풀이: 위상정렬 + queue 내부 정렬?
 이거로는 시간복잡도가 O(N(logN)*M)일 것 같았음
 무조건 1억은 안되겠다 싶었음
 그래서 했더니 되었다.
 
 4 - 2
 3 - 1
 이 있을 때
 시작지점을 둘다 큐에 넣는다 [4,3]
 큐를 정렬한다. [3,4]
 하나 빼고 위상정렬 한번 실시! [4, 1]
 다시 큐를 정렬 [1,4]
 하나 뺴고 위상정렬 실시 [4]
 다시 큐를 정렬 [4]
 하나 뺴고 위상정렬 실시 [2]
 ...
 
 2번 풀이
 위상정렬에서 queue에 넣을 때 그 queue가 우선순위 큐면 개꿀일듯
 */

let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = nm[0]
let m = nm[1]
var graph: [Int: [Int]] = [:]
for i in 1...n {
  graph.updateValue([], forKey: i)
}
var indegree = [Int](repeating: 0, count: n+1)
for _ in 0..<m {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  // a는 b보다 무조건 먼저 풀어야한다.
  let a = temp[0]
  let b = temp[1]
  graph[b]!.append(a)
  graph[a]!.append(b)
  indegree[b] += 1
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


var ans = ""
var queue = PriorityQueue<Int>(ascending: true)

for i in 1...n {
  if indegree[i] == 0 {
    queue.push(i)
  }
}

while !queue.isEmpty {
  let poped = queue.pop()!
  ans += "\(poped) "
  
  for i in graph[poped]! {
    indegree[i] -= 1
    if indegree[i] == 0 {
      queue.push(i)
    }
  }
  
}

print(ans)




