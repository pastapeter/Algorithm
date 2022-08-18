//
//  main.swift
//  시각
//
//  Created by Jung peter on 8/18/22.
//

import Foundation

let n = Int(readLine()!)!
var result = 0

for hour in 0...n {
    for min in 0..<60 {
        for sec in 0..<60 {
            if "\(hour)\(min)\(sec)".contains("3") {
                result += 1
            }
        }
    }
}
print(result)



