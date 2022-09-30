import Foundation

let input = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map {Int(String($0))!}

var dp = [Int](repeating: 0, count: input)
for index in 0..<input {
  dp[index] = 1
  for j in 0...index {
    if arr[j] < arr[index] && dp[index] < dp[j] + 1 {
      dp[index] = dp[j] + 1
    }
  }
}

print(dp.max()!)