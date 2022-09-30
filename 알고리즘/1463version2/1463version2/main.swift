//
//  main.swift
//  1463version2
//
//  Created by abc on 2021/07/06.
//

import Foundation

func function() -> Int{
    let input = Int(readLine()!)!
    if input == 1{
        return 0
    } else if input == 2{
        return 1
    } else if input == 3{
        return 1
    } else {
        var arr = [Int](repeating: 0, count: input+1)
        arr[1] = 0
        arr[2] = 1
        arr[3] = 1
        
        for i in 4...input{
            arr[i] = arr[i-1]+1
            if i%3 == 0{
                arr[i] = min(arr[i], arr[i/3]+1)
            }
            if i%2 == 0{
                arr[i] = min(arr[i], arr[i/2]+1)
            }
        }
        return arr[input]
    }
}

print(function())
