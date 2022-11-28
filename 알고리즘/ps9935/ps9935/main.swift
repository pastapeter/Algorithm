//
//  main.swift
//  ps9935
//
//  Created by Jung peter on 11/24/22.
//

import Foundation

func table(pattern: [String]) -> [Int] {

    var pi = [Int](repeating: 0, count: pattern.count)
    var j = 0
    
    for i in 1..<pattern.count {
        while j > 0 && pattern[i] != pattern[j] {
            j = pi[j-1]
        }
        if pattern[i] == pattern[j] {
            j += 1
            pi[i] = j
        }
    }
    return pi
}


func search(source: String, pattern: String) -> (Int, Int)? {
    var j = 0
    var patternArr = pattern.map {String($0)}
    var pi = table(pattern: patternArr)
    var sourceArr = source.map { String($0)}
    for i in sourceArr.indices {
        while j < 0 && sourceArr[i] != patternArr[j] {
            j = pi[j-1]
        }
        if sourceArr[i] == patternArr[j] {
            if j == patternArr.count - 1 {
                return (i-j, i)
            } else {
                j += 1
            }
        }
    }
    return nil
}


func solution() {
    var source = readLine()!
    var pattern = readLine()!
    
    while true {
        guard let range = search(source: source, pattern: pattern) else {break}
        let startIndex = source.index(source.startIndex, offsetBy: range.0)
        let endIndex = source.index(source.startIndex, offsetBy: range.1)
        source.removeSubrange((startIndex...endIndex))
    }
    
    if source.count == 0 {
        print("FRULA")
    } else {
        print(source)
    }
}

//solution()

func peekword(stack: inout [String], word: String, wordLength: Int, pattern: [String])  {
    stack += [word]
    var stacklen = stack.count
    var flag = true
    if (stacklen >= wordLength) {
        for i in 0..<wordLength {
            if !(stack[stacklen - wordLength + i] == pattern[i]) {
                flag = false
                break
            }
        }
        if flag {
            stack.removeSubrange((stacklen - wordLength)..<stacklen)
        }
    }
   
}


func solution2() {
    var source = readLine()!.map { String($0)}
    var pattern = readLine()!.map { String($0)}
    var j = pattern.count - 1
    var stack: [String] = []
    
    for s in source {
        if s != pattern[j] {
            stack.append(s)
        } else {
            peekword(stack: &stack, word: s, wordLength: j+1, pattern: pattern)
        }
    }
    
    if stack.count == 0 {
        print("FRULA")
    } else {
        print(stack.joined())
    }
}

solution2()



