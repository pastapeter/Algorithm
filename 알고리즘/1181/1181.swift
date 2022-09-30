var num = Int(readLine()!)!
var stringArray = [String]()
var result = [String]()
for _ in 0..<num {
    stringArray.append(readLine()!)
}
var removedDuplicated = Set(stringArray)
var newArray = Array(removedDuplicated)

var i = 0
result = newArray.sorted(by:{$0 < $1}).sorted(by:{$0.count < $1.count})


for i in result{
    print(i)
}
