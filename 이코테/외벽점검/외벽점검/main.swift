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
        let end = (n + (start-d)) % n // 시계 반대방향으로
        let filterWeaks = start > end ?
          w.filter {$0 < end || start+1...n ~= $0} : 
          w.filter {start+1..<end ~= $0 // 시계 반대방향으로 돌았을때의 미처 돌지 못한 취약점들
          }
        if filterWeaks.isEmpty {return index + 1} // 미처확인하지 못한 취약점이 남아있다면??
        newWeaks.insert(filterWeaks) // 그때 취약점을 새로운 취약점에 넣어라
      }
    }
    weaks = newWeaks
  }
    return -1
}

print(solution(12, [1,5,6,10], [1,2,3,4]))
