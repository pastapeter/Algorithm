//
//  main.swift
//  10828
//
//  Created by abc on 2021/03/17.
//

import Foundation


func push(_ list: inout [Int], _ input: Int){
    list.append(input)
    
}
func pop(_ list: inout [Int]){
    if(list.count == 0){
        print(-1)
    } else {
        print(list.removeLast())
    }
}
func size(_ list: [Int]){
    print(list.count)
}
func empty(_ list: [Int]){
    if (list.count == 0) {
        print(1)
    } else {
        print(0)
    }
}
func top(_ list: [Int]){
    if (list.count == 0) {print(-1)}
    else {
        print(list[list.count - 1])
    }
}

var list = [Int]()
var num = Int(readLine()!)!
for _ in 0..<num {
    let input = readLine()!.split(separator: " ")
    switch input[0] {
    case "push":
        push(&list, Int(input[1])!)
    case "pop" :
        pop(&list)
    case "size" :
        size(list)
    case "empty" :
        empty(list)
    case "top":
         top(list)
    default:
        continue
    }
}

