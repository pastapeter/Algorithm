//
//  main.swift
//  10799
//
//  Created by abc on 2021/06/26.
//

import Foundation

var input = readLine()!.map({$0})
var count = 0
var stick = 0
var result = 0

var stack = [Character]()

for i in 0..<input.count{
    if(input[i] == "("){
        stack.append(input[i])
    } else{
        if stack.last == "(" && input[i-1] == "("{ //레이저빔
            var _ = stack.popLast()!
            result += stack.count
        }
        else if stack.last == "(" {
            var _ = stack.popLast()!
            result += 1
        }
    }
}
print(result)
