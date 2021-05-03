//
//  main.swift
//  2579
//
//  Created by abc on 2021/04/29.
//

import Foundation

var input = Int(readLine()!)!
var scores = [Int](repeating: 0, count: input)
var dps = [Int](repeating: -1, count: input+1)
for i in 0..<input {
    scores[i] = Int(readLine()!)!
}
if(input >= 3){
    dps[0] = 0
    dps[1] = scores[0]
    dps[2] = max(dps[1]+scores[1], dps[0]+scores[1])
    for i in 3..<dps.count {
        //3칸을 밟을 수 없으니까
        //1개전, 3개전 칸 OR 2개전칸, 1개전을 밟고올냐
        dps[i] = max(dps[i-3]+scores[i-1]+scores[i-2], dps[i-2]+scores[i-1])
    }
} else if(input >= 2){
    dps[0] = 0
    dps[1] = scores[0]
    dps[2] = max(dps[1]+scores[1], dps[0]+scores[1])
} else if(input >= 1){
    dps[0] = 0
    dps[1] = scores[0]
} else {
    dps[0] = 0
}
print(dps[input])

