//
//  main.swift
//  커리큘럼
//
//  Created by Jung peter on 9/6/22.
//

import Foundation

let n = Int(readLine()!)!
var indegree = [Int](repeating: 0, count: n + 1)
var graph = [[Int]](repeating: [], count: n + 1)
var time = [Int](repeating: 0, count: n + 1)
var result = 0

for i in 1..<n+1 {
    var data = readLine()!.split(separator: " ").map { Int($0)! }
    time[i] = data[0]
    
    for x in data[1...] {
        if x == -1 {continue }
        graph[x].append(i)
        indegree[i] += 1
    }
}
print(graph)
print(indegree)
var results = time.map { return $0 }


func topologySort() {
    var queue = [Int]()
    
    for i in 1..<n+1 {
        if indegree[i] == 0 {
            queue.append(i)
        }
    }
    
    while !queue.isEmpty {
        
        let now = queue.removeFirst()
        
        for i in graph[now] {
            
            indegree[i] -= 1
            
            if indegree[i] == 0 {
                queue.append(i)
                results[i] = results[now] + time[i]
            }
        }
        
    }
    
    print(results)
}


topologySort()
