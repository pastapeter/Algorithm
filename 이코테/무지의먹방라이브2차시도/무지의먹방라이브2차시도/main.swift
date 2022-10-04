//
//  main.swift
//  무지의먹방라이브2차시도
//
//  Created by Jung peter on 10/4/22.
//

import Foundation

func solution2(_ food_times: [Int], _ k: Int64) -> Int {
    
    var k = k
    
    var foodTuple : [(index: Int, amount: Int)] = food_times.enumerated().map {
        return (index: $0.offset, amount: $0.element)
    }
    
    if food_times.reduce(0, +) <= k {
        return -1
    }
    
    
    var sortedFoodTuple = foodTuple.sorted(by: {
        $0.amount > $1.amount
    })
    
    var previous = 0
    // 어차피 sort하면 맨앞에꺼가 무조건 작거나 같겠지 마인드
    while k - Int64((sortedFoodTuple.last!.amount - previous) * sortedFoodTuple.count) >= 0 {
        
        let count = sortedFoodTuple.count
        let nowAmount = sortedFoodTuple.removeLast().amount
        k = k - Int64((nowAmount - previous) * count)
        previous = nowAmount
    }
    let foods = sortedFoodTuple.sorted(by: {$0.index < $1.index})
    return foods[Int(k%Int64(foods.count))].index + 1

}


func solution(_ food_times: [Int], _ k: Int64) -> Int {

    var k = k
    
    var foodTuple : [(index: Int, amount: Int)] = food_times.enumerated().map {
        return (index: $0.offset, amount: $0.element)
    }
    
    if food_times.reduce(0, +) <= k {
        return -1
    }
    
    
    var sortedFoodTuple = foodTuple.sorted(by: {
        $0.amount > $1.amount
    })
    
    var previous = 0
    // 어차피 sort하면 맨앞에꺼가 무조건 작거나 같겠지 마인드
    while k - Int64((sortedFoodTuple.last!.amount - previous) * sortedFoodTuple.count) >= 0 {
        
        let count = sortedFoodTuple.count
        let nowAmount = sortedFoodTuple.removeLast().amount
        k = k - Int64((nowAmount - previous) * count)
        previous = nowAmount
    }
    let foods = sortedFoodTuple.sorted(by: {$0.index < $1.index})
    return foods[Int(k%Int64(foods.count))].index + 1
}

print(solution([3,2,5,3,7],12))
