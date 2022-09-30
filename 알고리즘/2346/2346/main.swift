//
//  main.swift
//  2346
//


import Foundation

var num = Int(readLine()!)!
var deque = readLine()!.components(separatedBy: " ").map({Int($0)!})
var original = deque
var result = [Int]()

while true {
    let dequeued = deque.removeFirst()
    
    for i in 0..<original.count {
        if dequeued == original[i] {
            print("\(i+1)", terminator: " ")
        }
    }
    if deque.isEmpty {
        break
    }
    if dequeued > 0{
        for _ in 0..<dequeued-1{
            deque.append(deque.removeFirst())
        }
    } else {
        for _ in 0..<abs(dequeued){
            deque.insert(deque.removeLast(), at: 0)
        }
    }
}
