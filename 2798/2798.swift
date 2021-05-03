var input = readLine()!.split(separator: " ").map{Int($0)!}
var array = [Int]()
for _ in 0..<input[0] {
    array.append(Int(readLine()!)!)
}
var result = 0
var flag = false
let n = array.count
for i in 0..<n{
    for j in i+1..<n{
        for k in j+1..<n{
            let high = array[i]+array[j]+array[k]
            if (high == input[1]){
                result = high
                flag = true
                break;
            } else if(high < input[1]){
                result = max(result, high)
            } else {
                continue
            }
        }
        if(flag){break}
    }
    if(flag){break}
}
print(result)

