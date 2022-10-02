//
//  main.swift
//  국영수
//
//  Created by Jung peter on 10/1/22.
//

import Foundation

let n = Int(readLine()!)!
var arr = [(String, Int, Int, Int)]()
for _ in 0..<n {
    let tmp = readLine()!.split(separator: " ").map { String($0)}
    arr.append((tmp[0], Int(tmp[1])!, Int(tmp[2])!, Int(tmp[3])!))
}

arr.sort(by: {
    if $0.1 > $1.1 {
        return true
    } else if $0.1 == $1.1 {
        if $0.2 < $1.2 {
            return true
        } else if $0.2 == $1.2 {
            if $0.3 > $1.3 {
                return true
            } else if $0.3 == $1.3 {
                return $0.0 < $1.0
            } else {
                return false
            }
        }
        return false
    } else {
        return false
    }
})

arr.forEach {
    print($0.0)
}
