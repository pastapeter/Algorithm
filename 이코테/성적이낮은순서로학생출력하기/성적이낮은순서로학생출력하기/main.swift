//
//  main.swift
//  성적이낮은순서로학생출력하기
//
//  Created by Jung peter on 9/2/22.
//

import Foundation

let inputcount = Int(readLine()!)!
var dic: [(String, Int)] = []
for _ in 0..<inputcount {
    let new = readLine()!.split(separator: " ").map { String($0)}
    dic.append((new[0], Int(new[1])!))
}

let new = dic.sorted {
    $0.1 > $1.1
}
for student in new {
    print(student.0)
}

