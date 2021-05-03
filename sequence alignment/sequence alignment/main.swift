//
//  main.swift
//  sequence alignment
//
//  Created by abc on 2021/04/16.
//

import Foundation

var board = [[Int]](repeating: [0,0,0,0,0,0,0,0], count: 9)
var pathboard = [[Int]](repeating:[0,0,0,0,0,0,0,0], count: 9)
var column = "0abcdefg".map{$0}
var row = "0qbcdty".map{$0}
let x = column.count
let y = row.count
var diagram = 0
var up = 0
var left = 0
var answer = [String]()
// MAX값을 구하는 것임
//


//MARK: - needleman

for i in 0..<x{
    for j in 0..<y{
        if i == 0 || j == 0{
             board[j][i] = (-2)*(i+j)
            if i == 0 {
                pathboard[j][i] = -2
            } else {
                pathboard[j][i] = 2
            }
            if  i == 0 && j == 0 {
                pathboard[j][i] = 0
            }
        }
        else{
            // 대각선
            if(column[i] == row[j]){
                    diagram = board[j-1][i-1] + 1
            } else {
                diagram = board[j-1][i-1] - 1
            }
            // gap
            up = board[j-1][i] - 1
            left = board[j][i-1] - 1
            board[j][i] = max(diagram, up, left)
            if(board[j][i] == diagram){
                pathboard[j][i] = 1
            }
            else if (board[j][i] == up){
                pathboard[j][i] = 2
            }
            else {
                pathboard[j][i] = -2
            }
        }
    }
}
//MARK: - Back Tracking board

// 대각 1, 위에서 2, 왼쪽에서 -2
var yindex = y-1
var xindex = x-1


while(yindex != 0) {
    while(xindex != 0){
        if pathboard[yindex][xindex] == 1 {
            answer.append("dia")
            yindex -= 1
            xindex -= 1
        } else if pathboard[yindex][xindex] == 2 {
            answer.append("up")
            yindex -= 1
        } else {
            answer.append("left")
            xindex -= 1
        }
    }
}

print(answer)
var newcol = 1
var newrow = 1
var col = [Character]()
var ro = [Character]()

for i in answer.reversed(){
    if i == "dia" {
        col.append(column[newcol])
        ro.append(row[newrow])
        newcol += 1
        newrow += 1
    } else if i == "up" {
        col.append("_")
        ro.append(row[newrow])
        newrow += 1
    } else {
        col.append(column[newcol])
        ro.append("_")
        newcol += 1
    }
}

print(col)
print(ro)
//MARK: - waterman


//for i in 0..<x{
//    for j in 0..<y{
//        if i == 0 || j == 0{
//             board[j][i] = 0
//        }
//        else{
//            // 대각선
//            if(column[i] == row[j]){
//                    diagram = board[j-1][i-1] + 1
//            } else {
//                diagram = board[j-1][i-1] - 1
//            }
//            if diagram < 0 {
//                diagram = 0
//            }
//            // gap
//            up = board[j-1][i] - 1
//            left = board[j][i-1] - 1
//
//            if diagram < 0 {
//                diagram = 0
//            }
//            if up < 0 {
//                up = 0
//            }
//            if left < 0 {
//                left = 0
//            }
//
//            board[j][i] = max(diagram, up, left)
//        }
//    }
//}

//MARK: - print


for j in 0..<y{
    for i in 0..<x{
        print(board[j][i],terminator:" ")
    }
    print("\n")
}

for j in 0..<y{
    for i in 0..<x{
        print(pathboard[j][i],terminator:" ")
    }
    print("\n")
}


