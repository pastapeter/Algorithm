//
//  main.swift
//  외벽점검
//
//  Created by Jung peter on 9/23/22.
//

import Foundation

func solution(_ n:Int, _ weak:[Int], _ dist:[Int]) -> Int {

  var weaks: Set<[Int]> = [weak]
  for (index, d) in dist.reversed().enumerated() {
    var newWeaks: Set<[Int]> = []
    for w in weaks {
      for start in w {
        let end = (n + (start-d)) % n
        let filterWeaks = start > end ? w.filter {$0 < end || start+1...n ~= $0} : w.filter {start+1..<end ~= $0 }
        if filterWeaks.isEmpty {return index + 1}
        newWeaks.insert(filterWeaks)
      }
    }
    weaks = newWeaks
  }
    return -1
}

print(solution(12, [1,5,6,10], [1,2,3,4]))
