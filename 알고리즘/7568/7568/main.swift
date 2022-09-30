struct dunchi: Hashable{
    var weight: Int = 0
    var height: Int = 0
}
var students = [dunchi]()
var result = [Int]()
var input = Int(readLine()!)

for _ in (0..<input!) {
    var arr = [String]()
    var weight: Int!
    var height: Int!
    let infoInput = readLine()
    if let infoInput = infoInput{
        arr = infoInput.split(separator: " ").map(String.init)
    }
    weight = Int(arr[0])
    height = Int(arr[1])
    students.append(dunchi(weight: weight, height: height))
}
var count = 0
var j = 0

for i in 0..<students.count{
    count = 0
    while(j<students.count){
        if (students[i].height < students[j].height) && (students[i].weight < students[j].weight) {
            count += 1
        }
        j += 1
    }
    j = 0
    result.append(count+1)
}
for i in result{
    print(i, terminator:" ")
}

