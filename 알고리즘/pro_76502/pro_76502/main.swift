import Foundation

func check(_ s: [String]) -> Bool {
    var dic = [ ")": "(", "]":"[", "}":"{"]
    var stack: [String] = []
    for ele in s {
        if ele == "(" || ele == "{" || ele == "[" {
            stack.append(ele)
        } else {
            if stack.count == 0 { return false}
            else {
                if !(stack.last! == dic[ele]!) {
                    return false
                }
                stack.removeLast()
            }
        }
    }
    if stack.count > 0 {
        return false
    }
    return true
}

func move(_ s: [String]) -> [String] {
    var s = s
    let dequeue = s.removeFirst()
    s.append(dequeue)
    return s
}

func solution(_ s:String) -> Int {
    var s = s.map { String($0)}
    let len = s.count
    var result = 0
    if len == 1 { return 0}
    for _ in 0..<len-1 {
        if check(s) == true {
            result += 1
        }
        s = move(s)
    }
    return result
}
