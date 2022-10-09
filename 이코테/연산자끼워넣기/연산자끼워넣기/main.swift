//
//  main.swift
//  연산자끼워넣기
//
//  Created by Jung peter on 10/5/22.
//

import Foundation

let n = Int(readLine()!)!
var numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
var operators = readLine()!.split(separator: " ").map { Int(String($0))! }

func permutation(_ nums: [Int], _ targetNum: Int) -> [[Int]] {
    var result = [[Int]]()
    var visited = [Bool](repeating: false, count: nums.count)
    
    func permutation(_ nowPermute: [Int]) {
        if nowPermute.count == targetNum {
            result.append(nowPermute)
            return
        }
        for i in 0..<nums.count {
            if visited[i] == true {
                continue
            }
            else {
                visited[i] = true
                permutation(nowPermute + [nums[i]])
                visited[i] = false
            }
        }
    }
    permutation([])
    
    return result
}

func solution() {
    
    let count = operators.reduce(0, +)
    var arr: [Int] = []
    operators.enumerated().forEach {
        if $0.element > 0 {
            for _ in 0..<$0.element {
                arr.append($0.offset)
            }
        }
    }
    var resultArr: [Int] = []
    let operationOrders = Set(permutation(arr, count))
    // 0: +, 1: -, 2: x, 3: /
    
    for operationOrder in operationOrders {
        var nums = numbers
        var poped = nums.removeFirst()
        for operation in operationOrder {
            if operation == 2 {
                poped = poped * nums.removeFirst()
            } else if operation == 3 {
                poped = poped / nums.removeFirst()
            } else if operation == 0 {
                poped = poped + nums.removeFirst()
            } else {
                poped = poped - nums.removeFirst()
            }
        }
    
        resultArr.append(poped)
        
    }
    
    
    print(resultArr.max()!)
    print(resultArr.min()!)
    
}

//solution()

var maxVal = Int.min
var minVal = Int.max

func dfs(_ value: Int, _ index: Int) {
    
    if index == n {
        maxVal = max(value, maxVal)
        minVal = min(value, minVal)
    }
    
    for i in 0..<4 {
        if operators[i] == 0 {
            continue
        }
        operators[i] -= 1
        
        var result = value
        switch i {
        case 0:
            result += numbers[index]
        case 1:
            result -= numbers[index]
        case 2:
            result *= numbers[index]
        case 3:
            result /= numbers[index]
        default:
            break
        }
        
        dfs(result, index+1)
        operators[i] += 1
        
    }
}

dfs(numbers.first!, 1)
print(minVal)
print(maxVal)




