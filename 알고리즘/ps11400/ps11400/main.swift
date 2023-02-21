//
//  main.swift
//  ps11400
//
//  Created by Jung peter on 2/18/23.
//

let ve = readLine()!.split(separator: " ").map { Int(String($0))!}
let v = ve[0]
let e = ve[1]
var graph = [[Int]](repeating: [], count: v+1)
for _ in 0..<e {
  let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
  graph[temp[0]].append(temp[1])
  graph[temp[1]].append(temp[0])
}
var cnt = 0
var res = [(Int, Int)]()
var discovered = [Int](repeating: 0, count: 100001)

func dfs(now: Int, parent: Int) -> Int {
  cnt += 1
  discovered[now] = cnt
  var num = discovered[now]
  
  for next in graph[now] {
    
    // 부모 정점으로 가는 것은 제외
    if next == parent { continue }
    
    //일단 이미 방문했는지부터 확인해아함
    if discovered[next] == 0 { //방문을 안한거임
      var low = dfs(now: next, parent: now) // 방문함
      // 방문했을때, parent와 now의 L을 확인행햐ㅏㅁ
      num = min(low, num)
      if (low > discovered[now]) { //현재 발견시간보다, 자식 노드 발견시간이 늦을 때
        res.append((min(now, next), max(now,next)))
        
      }
    } else { num = min(num, discovered[next]) }
    
  }
  return num
}

dfs(now: 1, parent: 0)
print(res.count)

res.sort(by: { 
  if $0.0 == $1.0 {
    return $0.1 < $1.1
  } else if $0.0 < $1.0 {
    return true
  } else {return false}
})
for edge in res {
    print("\(edge.0) \(edge.1)")
}
