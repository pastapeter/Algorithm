//
//  main.swift
//  문자열뒤집기2차시도
//
//  Created by Jung peter on 10/6/22.
//

import Foundation

let input = readLine()!.map { Int(String($0))!}

func solution () -> Int {

    var dic = ["0":0 , "1": 0]
    var temp = "-1"

    for i in input {
        if temp == "-1" {
            temp = String(i)
            dic.updateValue(dic[temp]! + 1, forKey: temp)
        } else if String(i) == temp {
            continue
        } else {
            temp = String(i)
            dic.updateValue(dic[temp]! + 1, forKey: temp)
        }
    }
    
    return dic.min(by: {$0.value <= $1.value})!.value
}



print(solution())

