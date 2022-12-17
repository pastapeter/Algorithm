import Foundation



struct ParkingLot: Hashable {
  var v: Int
  var vacant: Int
}

struct Node: Comparable {
  static func < (lhs: Node, rhs: Node) -> Bool {
    lhs.priority < rhs.priority
  }
  var node: Int = 0
  var priority: Int = 0
}

func combi<T>(_ nums: [T], _ targetNum: Int) -> [[T]] {
  var result = [[T]]()
  
  func combination(_ index: Int, _ nowCombi: [T]) {
    if nowCombi.count == targetNum {
      result.append(nowCombi)
      return
    }
    
    for i in index..<nums.count {
      combination(i+1, nowCombi + [nums[i]])
    }
  }
  
  combination(0, [])
  return result
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

func solution(_ n:Int, _ edges:[[Int]], _ users:[Int], _ d:Int, _ limit:Int) -> Int {
  var parkingLots: [ParkingLot] = []
  for i in 0...users.count {
    parkingLots.append(ParkingLot(v: i, vacant: 0))
  }
  var candidates = combi(parkingLots, 2)
  var maxInt = Int.min
  //한번씩 다해보는데
  for i in candidates.indices {
    var newUsers = users
    newUsers.insert(0, at: 0)
    var asite = candidates[i][0]
    var bsite = candidates[i][1]

    asite.vacant = limit
    bsite.vacant = limit
    print(newUsers)
    // 일단 주차하기 asite
    if newUsers[asite.v] > asite.vacant {
      newUsers[asite.v] -= asite.vacant
      asite.vacant = 0
    } else if newUsers[asite.v] < asite.vacant {
      asite.vacant -= newUsers[asite.v]
      newUsers[asite.v] = 0
    } else {
      asite.vacant = 0
      newUsers[asite.v] = 0
    }
    
    // 일단 주차하기 bsite
    if newUsers[bsite.v] > bsite.vacant {
      newUsers[bsite.v] -= bsite.vacant
      bsite.vacant = 0
    } else if newUsers[bsite.v] < bsite.vacant {
      bsite.vacant -= newUsers[bsite.v]
      newUsers[bsite.v] = 0
    } else {
      bsite.vacant = 0
      newUsers[bsite.v] = 0
    }
    print(newUsers)
    
    
    for i in users.indices {
      if newUsers[i] > 0 {
        //  자전거를 가진 친구가 갈 수 있는 곳
        var nextIndices = findNextParkingLot(edges: edges, d: d, start: parkingLots[i], users: newUsers)
        // 그중에서 자리가 있는 곳
        print(nextIndices)
        for nIdx in nextIndices {
          if parkingLots[nIdx].vacant > newUsers[i] {
            parkingLots[nIdx].vacant -= newUsers[i]
            newUsers[i] = 0
          } else if parkingLots[nIdx].vacant < users[i] {
            newUsers[i] -= parkingLots[nIdx].vacant
            parkingLots[nIdx].vacant = 0
          } else {
            parkingLots[nIdx].vacant = 0
            newUsers[i] = 0
          }
        }
      }
    }
    print("---------------------")
    var tempAnswer = users.reduce(0, +) - newUsers.reduce(0, +)
    maxInt = max(maxInt, tempAnswer)
    
  
    for j in candidates[i].indices {
      candidates[i][j].vacant = 0
    }
  }
    return maxInt
}

func findNextParkingLot(edges: [[Int]], d: Int, start: ParkingLot, users: [Int]) -> [Int] {
  
  var graph = [[Node]](repeating: [Node](), count: users.count)
  for edge in edges {
    graph[edge[0]].append(Node(node: edge[1], priority: edge[2]))
  }
  var dist = [Int](repeating: Int.max, count: users.count)
  dist = dijkstra(start: start.v, graph: graph, dist: dist)
  var answer: [Int] = []
  for i in dist.indices {
    if dist[i] <= d {
      answer.append(i)
    }
  }
  return answer
}



func dijkstra(start: Int, graph: [[Node]], dist: [Int]) -> [Int] {
  var dist = dist
  dist[start] = 0
  var queue = PriorityQueue(ascending: true, startingValues: [Node(node: start, priority: 0)])
  
  while !queue.isEmpty {
    guard let now = queue.pop() else {break}
    let d = now.priority
    let n = now.node
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


print(solution(7, [[1,2,2], [5,2,2], [1,5,2], [1,3,1], [1,6,2], [1,7,3], [6,7,4], [7,4,1]], [0,2,0,0,0,4,1], 2, 3))
