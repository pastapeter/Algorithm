import Foundation

func numToBit(_ number: Int64) -> String {
    return "0" + String(number, radix: 2)
}

func bitToNum(_ bit: String) -> Int64 {
    return Int64(bit,radix: 2)!
}

func solution(_ numbers:[Int64]) -> [Int64] {
    var result = [Int64]()
    
    for number in numbers{
        var tryNumber = number
        if tryNumber % 2 == 0 {
            result.append(tryNumber + 1)
        } else {
            var input = numToBit(tryNumber).map{String($0)}
            
            var index = input.lastIndex(of: "0")!
            input[index] = "1"
            input[index + 1] = "0"
            
            var newStr = input.joined(separator: "")
            result.append(bitToNum(newStr))
        }
    }
    return result
}
