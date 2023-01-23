//
//  main.swift
//  정도현_0121
//
//  Created by Jung peter on 1/22/23.
//

import Foundation

let N = Int(readLine()!)!
let K = Int(readLine()!)!
var dp = [Int](repeating: 0, count: N+1)

var dp2 = [[Int]](repeating: [Int](repeating: -1, count: N+1), count: N+1)

// i 개색이 있을떄 아물것도 안고르는 경우는 1
// i 개색이 있을때, 1개를 고르는 경우는 i
for i in 0..<N+1 {
  dp2[i][0] = 1
  dp2[i][1] = i
}

func solution2(N: Int, K: Int) -> Int {
  
  if 2*K > N {
    dp2[N][K] = 0
    return 0
  }
  // 2*K == N 일때는 무조건 2임
  if (2*K == N) { return 2}
  
  if dp2[N][K] != -1 {
    return dp2[N][K]
  } else {
    dp2[N][K] = solution2(N: N-1, K: K) + solution2(N: N-2, K: K-1)
    dp2[N][K] %= 1000000003
    return dp2[N][K]
  }
}

print(solution2(N: N, K: K))




