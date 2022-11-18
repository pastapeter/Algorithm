//
//  main.swift
//  P2023
//
//  Created by Jung peter on 11/17/22.
//

import Foundation

let n = Int(readLine()!)!
let heads = [2,3,5,7]
let midNums = [1,3,7,9]
var ansArr: [String] = []
// 1의자리, 10의자리, 100의자리 .. n의 자리
for i in 1...n {
    if i == 1 {
        for head in heads {
            ansArr.append("\(head)")
        }
    } else {
        var temArr: [String] = []
        for ans in ansArr {
            for midNum in midNums {
                let resNum = Int("\(ans)\(midNum)")!
                if !isPrime(num:resNum) {continue}
                temArr.append("\(resNum)")
            }
        }
        ansArr = temArr
    }
}

func isPrime(num: Int) -> Bool {
    if (num < 4) {
        return num == 1 ? false : true
    }
    for i in 2...Int(sqrt(Double(num))) {
        if (num % i == 0) { return false }
    }
    return true
}

ansArr.forEach {
    print($0)
}
