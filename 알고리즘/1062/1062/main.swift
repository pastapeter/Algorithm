//
//  main.swift
//  1062
//
//  Created by Jung peter on 11/15/22.
//


import Foundation
var nk = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nk[0]
var k = nk[1]
var result = 0
var alphabet = 0
var wordsBit = Array(repeating: 0, count: 50)

for i in 0..<n{
    let a = readLine()!.map{String($0)}
    for j in a {
        wordsBit[i] |= 1 << (Int(Character(j).asciiValue! - Character("a").asciiValue!))
    }
}

func dfs(_ depth: Int, _ start: Int){
    
    var count = 0
    
    if depth == k{
        for i in 0..<n{
            // &연산자는 wordsBit[i] == alphabet이랑 같으면 1
            if wordsBit[i] & alphabet == wordsBit[i]{
                count += 1
            }
        }
        result = max(result, count)
        return
    }
    
    for i in start...25{
        if (alphabet & (1 << i)) == 0 //이미 방문했다면
        {
            // visited 처리 해
            alphabet = alphabet | (1 << i)
            // depth 추가
            dfs(depth + 1, i)
            // visited 해제
            alphabet = alphabet & ~(1 << i)
        }
    }
}
func solution2() -> Int{
    if k < 5{
        return 0
    }
    alphabet |= 1 << (Int(Character("a").asciiValue! - Character("a").asciiValue!))
    alphabet |= 1 << (Int(Character("n").asciiValue! - Character("a").asciiValue!))
    alphabet |= 1 << (Int(Character("t").asciiValue! - Character("a").asciiValue!))
    alphabet |= 1 << (Int(Character("i").asciiValue! - Character("a").asciiValue!))
    alphabet |= 1 << (Int(Character("c").asciiValue! - Character("a").asciiValue!))
    print(String(alphabet, radix: 2))
    k = k - 5
    dfs(0, 0)
    
    return result
}

print(solution2())


