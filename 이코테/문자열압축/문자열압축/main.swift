//
//  main.swift
//  문자열압축
//
//  Created by Jung peter on 9/12/22.
//

import Foundation

func solution(_ s:String) -> Int {
    
    var input = s.map { String($0) }
    var resultArr = [[String]](repeating: [], count: input.count)
    var result = Int.max
    
    var num = 1
    let mid = input.count / 2
    var start = 0
    
    if input.count == 1 {return 1}
    
    while num <= mid {
        if start + num <= input.count {
            resultArr[num].append(input[start..<start+num].joined())
        } else {
            resultArr[num].append(input[start...].joined())
        }
        start += num
        if start >= input.count {
            num += 1
            start = 0
        }
    }
    
    for i in resultArr.indices {
        
        if i > input.count / 2 {
            break
        }
        
        if resultArr[i].isEmpty {
            continue
        }
        var tmp = ("", 1)
        var new = ""
        
        for j in resultArr[i].indices {
            if tmp.0 == "" {
                tmp.0 = resultArr[i][j]
            } else if tmp.0 == resultArr[i][j] {
                tmp.1 += 1
            } else {
                if tmp.1 > 1 {
                    new += "\(tmp.1)\(tmp.0)"
                } else {
                    new += tmp.0
                }
                tmp = (resultArr[i][j], 1)
            }
        }
        // 마지막
        if tmp.1 > 1 {
            new += "\(tmp.1)\(tmp.0)"
        } else {
            new += tmp.0
        }
        
        if result > new.count {
            result = new.count
            print(new)
            new = ""
        }
    }
        
    return result
}

print(solution("a"))
