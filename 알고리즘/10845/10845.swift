import Foundation


var count = Int(readLine()!)!
var list = [Int]()
for _ in 0..<count{
    let input = readLine()!
    let command = input.split(separator: " ")
    switch command[0] {
    case "push":
        list.append(Int(command[1])!)
    case "pop":
        if(list.isEmpty) {print(-1)}
        else {print(list.removeFirst())}
    case "size":
        print(list.count)
    case "front":
        list.count == 0 ? print(-1) : print(list.first!)
    case "back":
        list.count == 0 ? print(-1) : print(list.last!)
    case "empty":
        list.count == 0 ? print(1) : print(0)
    default:
        continue
    }
}


