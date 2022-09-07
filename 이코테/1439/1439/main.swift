//
//  main.swift
//  1439
//
//  Created by Jung peter on 9/7/22.
//

import Foundation

let num = readLine()!
var dic = ["0":0 , "1": 0]
var temp = "-1"

for i in num {
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

print(dic.min(by: { $0.value <= $1.value })!.value)

