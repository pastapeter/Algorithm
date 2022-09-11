//
//  main.swift
//  무지의먹방라이브
//
//  Created by Jung peter on 9/10/22.
//

import Foundation

func solution(_ food_times:[Int], _ k:Int64) -> Int {
    
    var foodTimes = food_times
    let foodCount = foodTimes.count
    var count = -1
    var resultTime = -1
    while !(Set(foodTimes).count == 1 && Set(foodTimes).contains(0)) {
        
        if resultTime + 1 == k {
            
            // 다음 확인해야하는 인덱스 (count + 1) % foodCount
            var nextIndex = (count+1) % foodCount
            var i = 1
            while foodTimes[nextIndex] == 0 {
                if i >= foodCount {
                    return -1
                }
                nextIndex = (count+1+i) % foodCount
                i += 1
            }
            
            return nextIndex + 1
        }
        
        count += 1
        
        if foodTimes[count % foodCount] > 0 {
            foodTimes[count % foodCount] -= 1
            resultTime += 1
        }
    }
    
    return -1
}

func solution2(_ food_times:[Int], _ k:Int64) -> Int {
    var k = k
    var foodTimes = food_times
    var foodTuples = foodTimes.enumerated().map {
        return ($0.element, $0.offset)
    }
    foodTuples.sort(by: { $0.0 < $1.0 })
    
    if food_times.reduce(0, +) <= k {
        return -1
    }
    
    var current = 0
    var previous = 0
    var length = foodTuples.count
    
    
    for (i, food) in foodTuples.enumerated() {
        var diff = food.0 - previous
        if diff != 0 {
            let spend = diff * length
            if spend <= k {
                k -= Int64(spend)
                previous = food.0
            } else {
                k %= Int64(length)
                let foods = foodTuples[i...].sorted(by: { $0.1 < $1.1})
                return foods[Int(k)].1 + 1
            }
        }
        length -= 1 // 무조건 음식하나 다먹은거임
    }
    return -1
    
}

func solution3(_ food_times:[Int], _ k:Int64) -> Int {
    var k = k
    var foodTimes = food_times
    
    // Tuples로 나타내는 이유는 cost, index를 다 나타내주기 위해서
    var foodTuples = foodTimes.enumerated().map {
        return ($0.element, $0.offset)
    }
    
    foodTuples.sort(by: { $0.0 > $1.0 })
    
    if food_times.reduce(0, +) <= k {
        return -1
    }
    
    //전음식
    var previous = 0
    
    while k - Int64((foodTuples.last!.0 - previous) * foodTuples.count) >= 0 {
        var now = foodTuples.removeLast().0
        //여기서 1 더해주는 이유는 removeLast 했기때문에
        k -= Int64((foodTuples.count + 1) * (now - previous))
        previous = now
    }
    let foods = foodTuples.sorted(by: { $0.1 < $1.1})
    return foods[Int(k%Int64(foods.count))].1 + 1

    
}

print(solution3([3,1,2], 5))
