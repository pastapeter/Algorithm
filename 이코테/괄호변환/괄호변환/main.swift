//
//  main.swift
//  괄호변환
//
//  Created by Jung peter on 9/28/22.
//

import Foundation

func isBalanced(_ str: String) -> Bool {
    let str = str.map { String($0) }
    let left = str.filter { $0 == "("}.count
    let right = str.filter { $0 == ")"}.count
    return left == right
}

func isRight(_ str: String) -> Bool {
    var str = str.map { String($0) }
    if let ele = str.first, ele == ")" {
        return false
    }
    var stack: [String] = [str.removeFirst()]
    
    while !str.isEmpty {
        var ele = str.removeFirst()
        if ele == "(" {
            stack.append(ele)
        } else {
            let poped = stack.removeLast()
            if poped == "(" {
                continue
            } else {
                return false
            }
        }
    }
    
    if !stack.isEmpty { return false}
    
    return true
}

func devide2uAndv(_ str: String) -> String {
    
    //1
    if str == "" {return str}
    
    var answer = ""
    var u = ""
    var v = ""
    
    let str = str.map { String($0) }
    // 2 분리
    for i in stride(from: 1, to: str.count, by: 2) {
        u += str[i-1...i].joined()
        if isBalanced(u) {
            v = i >= str.count - 1 ? "" : str[(i+1)...].joined()
            break
        }
    }
    
    // 3 U가 올바른 문자열이라면?
    if isRight(u) {
        answer += u + devide2uAndv(v)
    } else {
        answer += "("+devide2uAndv(v)+")"
        let uArr = u.map{String($0)}
        for ele in uArr[1..<u.count-1] {
            answer += ele == ")" ? "(" : ")"
        }
    }
    return answer
}

func solution(_ p:String) -> String {
    
    return devide2uAndv(p)
}

print(solution("()))((()"))



