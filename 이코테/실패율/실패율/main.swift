//
//  main.swift
//  실패율
//
//  Created by Jung peter on 10/28/22.
//

import Foundation

func solution2(_ N:Int, _ stages:[Int]) -> [Int] {
    var wholeStage = Double(stages.count)
    var failDic = [Int:Double]()
    var result = [Int]()
    for i in 1...N {
        if(wholeStage != 0){
            var failure = Double(stages.filter{$0 == i}.count)
            failDic.updateValue(failure/wholeStage, forKey: i)
            wholeStage -= failure
        } else {
            failDic.updateValue(0, forKey: i)
        }
    }
    for i in failDic.sorted{$0.1  == $1.1 ? $0.0 < $1.0 : $0.1 > $1.1}{
        result.append(i.key)
    }
    return result
}

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    var result: [Int] = []
    var failDic: [Int: Double] = [:]
    var challenger = Double(stages.count)
    
    for i in 1..<N+1 {
        if challenger != 0 {
            var failure = Double(stages.filter{$0 == i}.count)
            failDic.updateValue(failure / challenger, forKey: i)
            challenger -= failure
        } else {
            failDic.updateValue(0, forKey: i)
        }
    }
    
    result = failDic.sorted(by: { $0.value == $1.value ? $0.key < $1.key : $0.value > $1.value})
        .map { return $0.key }

    return result
}


print(solution(4, [4,4,4,4,4]))
