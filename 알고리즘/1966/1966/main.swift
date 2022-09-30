//
//  main.swift
//  1966
//
//  Created by abc on 2021/06/27.
//

import Foundation

var queue = [Int]()
var rankQueue = [Int]()

var caseInput = Int(readLine()!)!

for _ in 0..<caseInput{
    var count = 0
    var flag = false
    var input = readLine()!.components(separatedBy: " ").map{ val in
        Int(val)!
    }
    let num = input[0]
    let location = input[1]
    
    let rankInput = readLine()!.components(separatedBy: " ").map { val in
        Int(val)!
    }
    
    for i in rankInput{ //rankqueue 초기화
        rankQueue.append(i)
    }
    
    for i in 0..<num{ //queue 초기화
        queue.append(i)
    }
    while(queue.contains(location)){
        var dequeued = (0, 0)
        dequeued.0 = queue.removeFirst()
        dequeued.1 = rankQueue.removeFirst()

        for i in rankQueue {
            if i > dequeued.1{
                queue.append(dequeued.0)
                rankQueue.append(dequeued.1)
                flag = true
                break
            }
        }
        
        if flag {
            flag = false
            continue
        }
        count += 1
    }
    print(count)
    queue.removeAll()
    rankQueue.removeAll()
}

