//
//  main.swift
//  ps19637
//
//  Created by Jung peter on 3/3/23.
//

import Foundation
// MARK: - 문제
/*
 게임 개발자인 밀리는 전투력 시스템을 만들어, 캐릭터가 가진 전투력을 기준으로 칭호를 붙여주려고 한다.

 예를 들어, 전투력 10,000 이하의 캐릭터는 WEAK, 10,000 초과 그리고 100,000 이하의 캐릭터는 NORMAL, 100,000 초과 그리고 1,000,000 이하의 캐릭터는 STRONG 칭호를 붙여준다고 하자. 이를 IF문으로 작성한다면 아래와 같이 구현할 수 있다.
 
 첫 번째 줄에는 칭호의 개수 N (1 ≤ N ≤ 105)과 칭호를 출력해야 하는 캐릭터들의 개수 M (1 ≤ M ≤ 105)이 빈칸을 사이에 두고 주어진다. (1 ≤ N, M ≤ 105)

 두 번째 줄부터 N개의 줄에 각 칭호의 이름을 나타내는 길이 1 이상, 11 이하의 영어 대문자로만 구성된 문자열과 해당 칭호의 전투력 상한값을 나타내는 109 이하의 음이 아닌 정수가 주어진다. 칭호는 전투력 상한값의 비내림차순으로 주어진다.

 N + 2번째 줄부터 M개의 각 줄에는 캐릭터의 전투력을 나타내는 음이 아닌 정수가 주어진다. 해당하는 칭호가 없는 전투력은 입력으로 주어지지 않는다
 */
// MARK: - 풀이
/*
 처음 풀이는 딕셔너리, Range를 활용해서 풀었다. 딕셔너리를 O(N)으로 돌면서 풀게되면 시간초과가 난다.
 칭호의 갯수가 100000개고
 구해야하는 M이 100000개니깐
 10000에서 100000을 서치해야하니 -> 10억 -> 시간초과 -> n, nlogn, logn의 시간복잡도를 찾아야함
 여기서 활용된 것은 이분탐색이다.
 칭호에 대해서 숫자를 Key, 칭소를 value로 둔다.
 그래서 해당 숫자가 이분탐색 리스트에 들어가게된다.
 들어오는 숫자 0, 9999, 10000 이고, 이분탐색리스트에서 sortedLevel[mid]을 비교한뒤에 크면 start를 mid+1로 옮겨준다.
 만약 sortedLevel[mid]가 10000이고 10001이 들어온다면, start를 mid+1로 해준다. 그리고 다음에 end가 start보다 앞으로 온다면, LevelData[sortedLevel[start]]
  총평: 이분탐색은 이분탐색인지 진짜 좀 알기 어려운듯.. 
 */

func wrongSolve() {
  let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
  let n = nm[0]
  let m = nm[1]
  var dic: [String:Range<Int>] = [:]
  var firstLimit = 0
  for _ in 0..<n {
    let temp = readLine()!.split(separator: " ").map { String($0)}
    let status = temp[0]
    let limit = Int(temp[1])!
    dic.updateValue(firstLimit..<limit+1, forKey: status)
    firstLimit = limit+1
  }

  for _ in 0..<m {
    let temp = Int(readLine()!)!
    for i in dic {
      if i.value ~= temp {
        print(i.key)
        break
      }
    }
  }
}

func solve() {
  let nm = readLine()!.split(separator: " ").map { Int(String($0))!}
  let n = nm[0]
  let m = nm[1]
  var levelData: [Int:String] = [:]
  var sortedLevel: [Int] = []
  for _ in 0..<n {
    let input = readLine()!.split(separator: " ").map { String($0)}
    if levelData[Int(input[1])!] == nil {
      levelData[Int(input[1])!] = input[0]
      sortedLevel.append(Int(input[1])!)
    }
  }
  sortedLevel.sort()
  
  for _ in 0..<m {
    let input = Int(readLine()!)!
    var start = 0
    var end = sortedLevel.count-1
    while start <= end {
      let mid = (start+end) / 2
      if sortedLevel[mid] < input {
        start = mid+1
      } else {
        end = mid-1
      }
    }
    print(levelData[sortedLevel[start]]!)
  }
  
}

solve()
