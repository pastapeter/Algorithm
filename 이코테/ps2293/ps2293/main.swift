//
//  main.swift
//  ps2293
//
//  Created by Jung peter on 3/24/23.
//

import Foundation

/*
 n가지 종류의 동전이 있다. 각각의 동전이 나타내는 가치는 다르다. 이 동전을 적당히 사용해서, 그 가치의 합이 k원이 되도록 하고 싶다. 그 경우의 수를 구하시오. 각각의 동전은 몇 개라도 사용할 수 있다.
 
 사용한 동전의 구성이 같은데, 순서만 다른 것은 같은 경우이다.
*/

let nk = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nk[0]
let k = nk[1]
var dp = [Int](repeating: 0, count: k+1)
var coins = [Int]()
for _ in 0..<n {
  coins.append(Int(readLine()!)!)
}
dp[0] = 1

for coin in coins {
  for i in 1...k {
    if i >= coin {
      if dp[i] + dp[i-coin] < Int(pow(2.0, 31.0)) { dp[i] += dp[i-coin]}
    }
  }
}

print(dp[k])

