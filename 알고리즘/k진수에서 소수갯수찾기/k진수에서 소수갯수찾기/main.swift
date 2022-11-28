import Foundation

func isPrime(_ n: Int) -> Bool {
    if n < 4 {
        if n == 1 || n == 0 {return false}
        return true
    }

    for i in 2..<(Int(sqrt(Double(n))) + 1) {
        if n % i == 0 {
            return false
        }
    }
    return true
}

func solution(_ n:Int, _ k:Int) -> Int {
    var newInput = String(n, radix: k).map { Int(String($0))!}
    print(newInput)
    var stack: [Int] = []
    var answer = 0
    for i in newInput {
        if stack.isEmpty {
            stack.append(i)
        } else {
            if i == 0 {
                var temp = ""
                while !stack.isEmpty {
                    temp = "\(stack.removeLast())" + temp
                }
                guard let val = Int(temp) else { continue }
                if isPrime(val) { answer += 1 }
            } else {
                stack.append(i)
            }
        }
    }
    
    var temp = ""
    while !stack.isEmpty {
        let poped = stack.removeLast()
        if  poped == 0 { continue }
        temp = "\(poped)" + temp
    }
    guard let lastVal = Int(temp) else { return answer}
    if isPrime(lastVal) { answer += 1}
    
    return answer
}

