//
//  main.swift
//  ps16987
//
//  Created by Jung peter on 3/10/23.
//

import Foundation

struct Egg {
  var s: Int
  var w: Int
}

let n = Int(readLine()!)!
var eggs = [Egg]()
for _ in 0..<n {
  let tmp = readLine()!.split(separator: " ").map { Int(String($0))!}
  eggs.append(Egg(s: tmp[0], w: tmp[1]))
}

var start = 0
for end in 0..<n {
  
}

