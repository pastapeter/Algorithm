//
//  main.swift
//  N으로 표현
//
//  Created by Jung peter on 9/30/22.
//

import Foundation

func solution(_ N:Int, _ number:Int) -> Int {
    
    var answer = -1
    if N == number {
        return 1
    }
    
    // 1 SET * 8 초기화
    var s = [Set<Int>](repeating: [], count: 9)
    
    for index in s.indices {
        if index == 0 {continue}
        s[index].insert( Int([String](repeating: "\(N)", count: index).joined())! )
    }
    
    for i in 1..<9 {
        // i 가 1
        for j in 0..<i {
            for op1 in s[j] {
                for op2 in s[i-j] {
                    s[i].insert(op1 + op2)
                    s[i].insert(op1 - op2)
                    s[i].insert(op1 * op2)
                    if op2 != 0 {
                        s[i].insert(op1 / op2)
                    }
                }
            }
        }
        print(s[i])
        if s[i].contains(number) {
            answer = i
            break
        } else {
            answer = -1
        }
    }
    
    return answer
}

//func solution2(_ N:Int, _ number:Int) -> Int {
//    if N == number {
//        return 1
//    }
//
//    var answer: Int = -1
//
//    func dfs(_ count: Int, _ now: Int) {
//        if count > 8 { return }
//
//        if now == number {
//            answer = count
//            return
//        }
//
//        var NN = 0
//        for i in 0..<8 {
//            if answer != -1 && answer < count + 1 + i {
//                break
//            }
//            // 8까지가면서, 5, 55, 555, 5555, 55555 ...
//            NN = NN*10 + N
//            print(count+1+i, NN)
//            dfs(count + 1 + i, now + NN)
//            dfs(count + 1 + i, now - NN)
//            dfs(count + 1 + i, now * NN)
//            dfs(count + 1 + i, now / NN)
//        }
//    }
//
//    dfs(0, 0)
//
//    return answer
//}


print(solution(5, 12))

