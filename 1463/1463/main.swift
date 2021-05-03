//
//  main.swift
//  1463
//
//  Created by abc on 2021/04/29.
//

import Foundation

var input = Int(readLine()!)!
var dps = [Int](repeating: -1, count: input+1)
if(input>=4){
    dps[0] = 0
    dps[1] = 0
    dps[2] = 1
    dps[3] = 1
    for i in 4..<dps.count {
        if(i%2 != 0 && i%3 != 0){
            dps[i] = dps[i-1] + 1
        } else if(i%2 == 0 || i%3 == 0){
            if(i%2 == 0 && i%3 != 0){
                dps[i] = min(dps[i/2] + 1, dps[i-1] + 1)
            } else if(i%2 != 0 && i%3 == 0){
                dps[i] = min(dps[i/3] + 1, dps[i-1]+1)
            } else{
                dps[i] = min(dps[i/3]+1, dps[i/2]+1)
            }
        }
    }
} else if (input >= 3){
    dps[0] = 0
    dps[1] = 0
    dps[2] = 1
    dps[3] = 1
} else if(input >= 2){
    dps[0] = 0
    dps[1] = 0
    dps[2] = 1
} else if(input >= 1){
    dps[0] = 0
    dps[1] = 0
} else {
    dps[0] = 0
}
print(dps[input])
