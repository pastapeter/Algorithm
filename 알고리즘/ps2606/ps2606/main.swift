//
//  main.swift
//  ps2606
//
//  Created by Jung peter on 2/11/23.
//

import Foundation

let node = Int(readLine()!)!
let v = Int(readLine()!)!
var graph = [[Int]]()
var parents = [Int](repeating: 0, count: node)

for i in parents.indices {
  parents[i] = i
}

for _ in 0..<v {
  let temp = readLine()!.split(separator: " ").map{ Int(String($0))! }
  graph.append(temp)
}

func union(node1: Int, node2: Int) {
  var rootnode1 = findroot(node1)
  var rootnode2 = findroot(node2)
  
  if rootnode1 == rootnode2 {
    return
  } else {
    parents[rootnode1] = rootnode2
    return
  }
}

func findroot(_ node: Int) -> Int {
  var parentnode = parents[node]
  if parentnode != node {
    return findroot(parentnode)
  } else {
    return parentnode
  }
}

func findparent(_ node1: Int, _ node2: Int) -> Bool {
  var rootnode1 = findroot(node1)
  var rootnode2 = findroot(node2)
  if rootnode1 == rootnode2 {
    return true
  }
  return false
}



