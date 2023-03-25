//
//  main.swift
//  ps1806
//
//  Created by Jung peter on 3/25/23.
//

import Foundation

/*
 10,000 이하의 자연수로 이루어진 길이 N짜리 수열이 주어진다. 이 수열에서 연속된 수들의 부분합 중에 그 합이 S 이상이 되는 것 중, 가장 짧은 것의 길이를 구하는 프로그램을 작성하시오.
 */

/*
 부분합 - 투포인터를 활용하는방법이다.
 지렁이가 굴러가듯 합을 구해주면된다.
 대신 만약에 합이 s 보다 클때는 start를 앞으로 땡기고, end를 다시 뒤로보내주면서 다음 방문때 end는 현 위치를 유지해야한다.
 */

let ns = readLine()!.split(separator: " ").map { Int(String($0))!}
let n = ns[0]
let s = ns[1]
var nums = readLine()!.split(separator: " ").map { Int(String($0))!}

var start = 0
var ans = Int.max
var end = -1
var sum = 0
// 5 1 3 5 10 7
while start < n && end < n {
  end += 1
  if end >= n { break }
  sum += nums[end]
  if sum >= s {
    ans = min(ans, end-start+1)
    sum -= nums[start]
    sum -= nums[end]
    start += 1
    end -= 1
  }
}

if ans == Int.max {
  print(0)
} else { print(ans)}

