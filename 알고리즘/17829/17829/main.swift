import Foundation

var num = Int(readLine()!)!
var temp = [Int](repeating: 0, count: 1024)
var matrix = [[Int]](repeating: temp, count: 1024)

for i in (0..<num).reversed(){
    let input = readLine()!.components(separatedBy: " ").map({Int($0)!})
    for j in 0..<input.count{
        matrix[i][j] = input[j]
    }
}


func pulling(_ x: Int, _ y: Int)->Int{
    var chosen = [Int]()
    for i in y..<y+2{
        for j in x..<x+2{
            chosen.append(matrix[i][j])
        }
    }
    return chosen.sorted()[2]
}

while num > 1{
    for i in stride(from: 0, to: num, by: 2){
        for j in stride(from: 0, to: num, by: 2){
            matrix[i/2][j/2] = pulling(j, i)
        }
    }
    num = num/2
}
print("\(matrix[0][0])")



