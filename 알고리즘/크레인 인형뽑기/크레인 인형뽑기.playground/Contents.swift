import Foundation

func solution(_ board:[[Int]], _ moves:[Int]) -> Int {
    var basket = [Int]()
    var popcount = 0
    var y = board.count
    var x = board[0].count
    var newboard = [[Int]](repeating:Array(repeating: 0, count: x), count:y)
    for i in 0..<y{
        for j in 0..<x{
            newboard[j][i] = board[i][j]
        }
    }
    for i in moves {
        for index in 0..<newboard[i-1].count{
            if newboard[i-1][index] != 0 {
                if(basket.last == newboard[i-1][index]){
                    popcount += 2
                    basket.removeLast()
                } else {
                    basket.append(newboard[i-1][index])
                }
                newboard[i-1][index] = 0
                break
            }
        }
    }
    return popcount
}

