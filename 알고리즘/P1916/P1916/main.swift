//
//  main.swift
//  P1916
//
//  Created by Jung peter on 11/17/22.
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


let n = Int(readLine()!)!
let m = Int(readLine()!)!
var graph = [[Node]](repeating: [Node](), count: n+1)



for _ in 2..<m+2 {
    let info = readLine()!.split(separator: " ").map { Int(String($0))! }
    
    graph[info[0]].append(Node(node: info[1], priority: info[2]))
}

let fromto = readLine()!.split(separator: " ").map { Int(String($0))!}
var from = fromto[0]
var to = fromto[1]
var dist = [Int](repeating: Int.max, count: n+1)
print(dijkstra(start: from)[to])

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



