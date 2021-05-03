import Foundation

func Solution(i: Int, j: Int) -> Int {
    var opt = 0
    var penalty = 0
    let x: [Character] = "TAAGGTCA".map{$0}
    let y: [Character] = "AACAGTTACC".map{$0}
    if (i == x.count){
        opt += 2*(y.count - j)
        return opt
    }
    else if (j == y.count){
        opt += 2*(x.count - i)
        return opt
    }
    else {
        if x[i] == y[j] {
            penalty = 0
        } else {
            penalty = 1
        }
        opt =  min(Solution(i: i+1, j: j+1)+penalty, Solution(i: i+1, j: j)+2, Solution(i: i, j: j+1)+2)
    }
    return opt
}

print(Solution(i: 0, j: 0))
