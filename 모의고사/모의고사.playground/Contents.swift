
import Foundation

func solution(_ answers:[Int]) -> [Int] {
    var count1 = 0, count2 = 0, count3 = 0
    let arr3 = [3,3,1,1,2,2,4,4,5,5], arr2 = [2, 1, 2, 3, 2, 4, 2, 5], arr = [1,2,3,4,5]
    var result = [Int]()
    var result2 = [Int]()
    
    for i in 0..<answers.count {
        if answers[i] == arr[i%arr.count] {
            count1 += 1
        }
        if answers[i] == arr2[i%arr2.count] {
            count2 += 1
        }
        if answers[i] == arr3[i%arr3.count]{
            count3 += 1
        }
    }
    result.append(count1)
    result.append(count2)
    result.append(count3)
    for i in 0..<result.count{
        if result[i] == result.max()! {
            result2.append(i+1)
        }
    }
    return result2
}


