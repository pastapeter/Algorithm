//
//  main.swift
//  1935
//
//  Created by abc on 2021/06/26.
//

import Foundation

var index = 0
var input = Int(readLine()!)!
var sentence = readLine()!.map { val in
    return val
}
var number = [Int]()
for _ in 0..<input{
    number.append(Int(readLine()!)!)
}
var newSentence = [String]()
var letter = Set<String>()
for i in sentence{
    if i.isLetter {
        letter.insert(String(i))
    }
}
let array = Array(letter).sorted()
var dic = [String: Int]()

for i in 0..<array.count{
    dic.updateValue(number[i], forKey: array[i])
}

for i in sentence{
    if dic.keys.contains(String(i)){
        newSentence.append(String(dic[String(i)]!))
    } else {
        newSentence.append(String(i))
    }
}

var stack = [Double]()

for i in 0..<newSentence.count{
    let num = Double(newSentence[i])
    if num != nil {
        stack.append(num!)
    } else{
        let op2 = Double(stack.popLast()!)
        let op1 = Double(stack.popLast()!)
        switch newSentence[i] {
        case "+":
            stack.append(op1+op2)
        case "*":
            stack.append(op1*op2)
        case "-":
            stack.append(op1-op2)
        case "/":
            stack.append(op1/op2)
        default:
            continue
        }
    }
}

print(String(format: "%.2f", stack.popLast()!))
