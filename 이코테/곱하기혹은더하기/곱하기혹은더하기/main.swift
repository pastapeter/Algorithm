//
//  main.swift
//  곱하기혹은더하기
//
//  Created by Jung peter on 9/7/22.
//

import Foundation

let number = readLine()!
var numArr = [Int]()
for i in number.indices {
    let strIndex = number.index(i, offsetBy: 0)
    numArr.append(Int(number[i...strIndex])!)
}

numArr.sort()
var result = 0
for num in numArr {
    if num <= 1 || result == 0 {
      result += num
    } else {
        result *= num
    }
}


print(result)


