//
//  main.swift
//  EditDistanceRecursive
//
//  Created by abc on 2021/04/17.
//

import Foundation

let A = "DISTANCE".map{$0}
let B = "EDITING".map{$0}

func Solution(x: Int, y: Int) -> Int{
    //basecase
    var opt = 0;
    var penalty = 0
    if (x == A.count){
        opt += A.count - y
        return opt
    }
    else if(y == B.count){
        opt += B.count - x
        return opt
    }
    else{
        if (A[x] == B[y]){
            penalty = 0
        } else {
            penalty = 1
        }
        opt = min(Solution(x: x+1, y: y+1)+penalty, Solution(x: x+1, y: y)+2, Solution(x: x, y: y+1)+2)
        return opt;
    }
}


print(Solution(x: 0, y: 0))
