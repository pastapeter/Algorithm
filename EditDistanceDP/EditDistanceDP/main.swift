//
//  main.swift
//  EditDistanceDP
//
//  Created by abc on 2021/04/17.
//

import Foundation

let A = "DISTANCE"
let B = "EDITING"
var board = [[Int]](repeating: [0,0,0,0,0,0,0,0,0], count: 8)
var pathboard = [[Int]](repeating: [0,0,0,0,0,0,0,0,0], count: 8)

func Solution(a: String, b: String, board: inout [[Int]], pathboard: inout [[Int]]) -> Int {
    var column = a.map{$0}
    column.insert("0", at: 0)
    var row = b.map{$0}
    row.insert("0", at: 0)
    for y in 0..<row.count {
        for x in 0..<column.count {
            if x == 0 || y == 0 {
                board[y][x] = (x+y);
                if(y == 0) {
                    pathboard[0][x] = 1
                } else {
                    pathboard[y][0] = 2
                }
            }
            else {
                // 여기서 4가지로 나뉨 match / mismatch / deletion / insertion
                // row[i]와 column[i]가 같을 경우에는 전의 것과 동일함 대각선
                // row[i]와 column[i]가 다를 경우에는
                // deletion, insertion, mismatch를 정해줘야하는데, mininum이므로 가장 min 값을 구해주면된다.
                // 하지만 그럼에도 우선순위를 어떻게 줄것인가에 대한 문제가 발생함
                // 하지만 생각해보면, 삭제가 먼저이고 다 삭제했을 경우, 삭제할 경우가 없을때, 삽입하는것이 맞다.
                // 근데 어차피 미니멈을 구하는 것이면 2개다 존재할 경우에 삽입을 먼저하던 삭제를 먼저하던 바꿔주던 굳이? 상관은 없다. 그냥 최선의 값만 찾으면 되는것
                // 또한 y축에 있는 것이 x 축보다 크다면,
                // 하지만 백트래킹이라면?? 백트래킹이라면 화살표를 저장하기 떄문에 전 친구가 2개를 보냇던 3개를 보냇던 중요하지 않다. 자기가 받은 화살표가 어디서 왔는지만 파악하면 된다는 것
                // 백트래킹시 mismatch = 변경 3 아래로 내려가는것은 x줄 비교안햇는데 y줄만 하나 더 플러스 해서 비교했다는 뜻임, 이말은 결국 x줄에 _ 하나생겼다는 이야기임 2임 // 옆으로 가는것은 y줄 비교안했는데 x줄만 하나 더 비교했다는 소리,

                if column[x] == row[y] {
                    board[y][x] = board[y-1][x-1]
                    pathboard[y][x] = 0;
                } else {
                    board[y][x] = min(board[y-1][x]+1, board[y-1][x-1]+1, board[y][x-1]+1)
                    if board[y][x] == board[y-1][x-1]+1 {
                        pathboard[y][x] = 3
                    } else if board[y][x] == board[y-1][x]+1 {
                        pathboard[y][x] = 2
                    } else {
                        pathboard[y][x] = 1
                    }
                }
            }
        }
    }
    return board.last!.last!;
}

func backTracking(a: String, b: String, pathboard: inout [[Int]]) {
    var column = a.map{$0}
    column.insert("0", at: 0)
    var row = b.map{$0}
    row.insert("0", at: 0)
    var x = column.count - 1
    var y = row.count - 1
    var ResultA = [Character]()
    var ResutlB = [Character]()
    while(x > 0 || y > 0){
        switch pathboard[y][x] {
        case 3:
            ResultA.append(column[x])
            ResutlB.append(row[y])
            x -= 1
            y -= 1
        case 1:
            ResultA.append(column[x])
            ResutlB.append("_")
            x -= 1
        case 2:
            ResultA.append("_")
            ResutlB.append(row[y])
            y -= 1
        case 0:
            ResultA.append(column[x])
            ResutlB.append(row[y])
            x -= 1
            y -= 1
        default:
            continue
        }
    }
    ResultA = ResultA.reversed()
    ResutlB = ResutlB.reversed()
    print(ResultA)
    print(ResutlB)
}

print(Solution(a: A, b: B, board: &board, pathboard: &pathboard))
for y in pathboard.indices{
    for x in pathboard.first!.indices{
        print(pathboard[y][x], terminator: " ")
    }
    print("\n")
}
backTracking(a: A, b: B, pathboard: &pathboard)


