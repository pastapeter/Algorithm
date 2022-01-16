import Foundation

func solution(_ n:Int) -> [Int] {
    
    let limit = n * (n + 1) / 2
    var countLimit = n - 1
    var result = [[Int]]()
    var point = (0,0)
    var start = 1
    var leftFlag = true
    var bottomFlag = false
    var rightFlag = false
    var count = 0
    
    for i in 1...n {
        var arr = [Int](repeating: -1, count: i)
        result.append(arr)
    }
    
    while(start <= limit) {
        count += 1
        if result[point.0][point.1] == -1 && leftFlag == true{
            
            result[point.0][point.1] = start
            point = (point.0 + 1, point.1)
            
            if count == countLimit {
                leftFlag = false
                bottomFlag = true
                count = 0
            }
        } else if result[point.0][point.1] == -1 && bottomFlag == true {
            result[point.0][point.1] = start
            point = (point.0, point.1 + 1)
            
            if count == countLimit {
                bottomFlag = false
                rightFlag = true
                count = 0
            }
            
        } else if result[point.0][point.1] == -1 && rightFlag == true {
            result[point.0][point.1] = start
            if count == countLimit {
                point = (point.0 + 1, point.1)
                rightFlag = false
                leftFlag = true
                count = 0
                countLimit = countLimit - 3
            } else {
                point = (point.0 - 1, point.1 - 1)
            }
        }
        start += 1
    }
    return Array(result.joined())
}

print(solution(2))
