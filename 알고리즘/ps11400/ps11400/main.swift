//
//  main.swift
//  ps11400
//
//  Created by Jung peter on 2/18/23.
//

let ve = readLine()!.split(separator: " ").map { Int(String($0))!}
let v = ve[0]
let e = ve[1]
var graph = [[Int]](repeating: [], count: v+1)
for _ in 0..<e {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
  graph[temp[0]].append(temp[1])
  graph[temp[1]].append(temp[0])
}
var cnt = 0
var order: [Int] = []
var visited = [Int](repeating: 0, count: v+1)
var edge = [Int](repeating: 0, count: e+1)

func dfs(parent: Int, start: Int) -> Int {
  

}
