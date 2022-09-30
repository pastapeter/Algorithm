//
//  main.swift
//  12865
//
//  Created by abc on 2021/06/10.
//

import Foundation

var input = readLine()!.split(separator: " ").map({Int($0)!})
let K = input[1] //배낭의 무게
let N = input[0] //물품의 수
var stuffweight = [Int](repeating: 0, count: N+1)
var stuffprice = [Int](repeating: 0, count: N+1)
var array = [Int](repeating: 0, count: K+1)
var p = [[Int]](repeating: array, count: N+1)

for i in 1..<N+1{
    let stuff = readLine()!.split(separator: " ").map({Int($0)!})
    stuffweight[i] = stuff[0]
    stuffprice[i] = stuff[1]
}


// 01knapsack problem3
for y in 1..<N+1{
    for x in 1..<K+1{ //x축은 배낭의 무게
        if(stuffweight[y]<=x){
            p[y][x] = max(p[y-1][x], p[y-1][x-stuffweight[y]]+stuffprice[y])
        } else{
            p[y][x] = p[y-1][x]
        }
    }
}
print(p[N][K])

