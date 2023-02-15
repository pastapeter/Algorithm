//
//  main.swift
//  ps22865
//
//  Created by Jung peter on 2/14/23.
//

import Foundation

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

func dijkstra(start: Int) -> [Int] {
  dist[start] = 0
  var queue = PriorityQueue(ascending: true, startingValues: [Node(node: start, priority: 0)])
  
  while !queue.isEmpty {
    // 우선순위 큐에서 하나 빼기, 가장 우선순위가 작은것을 꺼냄 (최소힙)
    guard let now = queue.pop() else {break}
    let d = now.priority
    let n = now.node
    //최소힙에서 나온것과 , dist[]의 값을 비교한뒤에, dist가 가장 작으면 일단 dist를 업데이트 할 필요없다.
    if dist[n] < d {
      continue
    }
    
    for next in graph[now.node] {
      let distance = next.priority + d
      if distance < dist[next.node] {
        dist[next.node] = distance
        queue.push(Node(node: next.node, priority: dist[next.node]))
      }
    }
  }
  
  return dist
}

//다익스트라 짜기 연습
// start는 node로 정하고, 방출은 해당 node에서 얼마나 거리가있는지? [거리]
func dijkstra2(start: Node) -> [Int] {
  //1. 일단 시작지점은 0으로 바꿔줌
  dist[start.node] = 0
  //2. pq로 선언해준다.
  var pq = PriorityQueue(ascending: true, startingValues: [start])
  
  //3. pq가 끝날때까지 가까운 노드부터 방문을 하면서 dist값을 변경할 수 있음
  while !pq.isEmpty {
    
    // 현위치
    let now = pq.pop()!
    let d = now.priority
    let n = now.node
    
    // dist[node] < dist 보다 작으면 갈필요없음
    if dist[n] < d {
      continue
    }
    
    for next in graph[n] {
      let distance = next.priority + d // 현 위치에서 다음 위치까지 거리 + 현 위치까지 오는데 가장 짧은 거리
      if distance < dist[next.node] { //원래 nextnode까지 가는데 걸리는 것보다, 현 위치를 거쳐서 가는게 더 빠르다면
        dist[next.node] = distance // 현위치 거쳐서 가는걸로 변경해주고
        pq.push(Node(node: next.node, priority: distance)) // 우선순위큐에 저장
      }
      
    }
  }
  return dist
}

let n = Int(readLine()!)!
let abc = readLine()!.split(separator: " ").map { Int(String($0))!}
let loads = Int(readLine()!)!
var graph = [[Node]](repeating: [Node](), count: n+1)
var dist = [Int](repeating: Int.max, count: n+1)
for _ in 0..<loads {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
  // D E D-E
  let node1 = Node(node: temp[1], priority: temp[2])
  graph[temp[0]].append(node1)
  let node2 = Node(node: temp[0], priority: temp[2])
  graph[temp[1]].append(node2)
}

var maxdist: [Int] = []
var maxdistIndex: [Int] = []
for i in abc {
  let maxresult = dijkstra(start: i)[1...].max()!
  maxdist.append(maxresult)
  maxdistIndex.append(dijkstra(start: i).firstIndex(of: maxresult)!)
}

print(maxdistIndex[maxdist.firstIndex(of: maxdist.min()!)!])

//print(minInt)

