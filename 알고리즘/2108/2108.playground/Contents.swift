import UIKit

func first(_ numbers: [Int]) -> Int {
    var result = 0
    for i in numbers{
        result = result + i
    }
    return result / numbers.count
}

func second(_ numbers: [Int]) -> Int {
    var numbers = numbers
    let first = 0
    let last = numbers.count-1
    let mid = (first + last) / 2
    for i in 0..<numbers.count{
        for j in 0..<numbers.count-1{
            if(numbers[j] > numbers[j+1]){
                var temp: Int!
                temp = numbers[j]
                numbers[j] = numbers[j+1]
                numbers[j+1] = temp
            }
        }
    }
    return numbers[mid]
}

func third(_ numbers: [Int]) -> Int {
    var dic = [Int:Int]()
    for i in numbers{
        if dic.keys.isEmpty {
            dic.updateValue(1, forKey: i)
        } else{
            for j in dic.keys{
                if j == i {
                    dic[j]! += 1
                } else {
                    dic.updateValue(1, forKey: i)
                }
            }
        }
    }
    let sortedDic = dic.sorted(by: {$0.1 > $1.1})
    for i in 0..<sortedDic.count - 1{
        if (sortedDic[i] == sortedDic[i+1]){
            
        }
    }
    return sortedDic[0].value
}

func fourth(_ numbers: [Int]) -> Int {
    var numbers = numbers
    let first = 0
    let last = numbers.count - 1
    for i in 0..<numbers.count{
        for j in 0..<numbers.count-1{
            if(numbers[j] > numbers[j+1]){
                var temp: Int!
                temp = numbers[j]
                numbers[j] = numbers[j+1]
                numbers[j+1] = temp
            }
        }
    }
    return numbers[last] - numbers[first]
}

var input = 5
var numbers = [Int]()
numbers = [1,3,8,-2,2]
//for _ in 0..<input{
//    let num = Int.random(in: 0..<4000)
//    numbers.append(num)
//}
print(first(numbers))
print(second(numbers))
print(third(numbers))
print(fourth(numbers))


