var numbers = readLine()!.split(separator: " ").map { Int($0)!}
let pointA = (x: numbers[0], y: numbers[1])
let pointB = (x: numbers[2], y: numbers[3])
var arr = [Int]()
arr.append(abs(0 - pointA.x))
arr.append(abs(pointB.x - pointA.x))
arr.append(abs(pointB.y - pointA.y))
arr.append(abs(0 - pointA.y))
print(arr.min()!)
