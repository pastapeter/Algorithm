//
//  main.swift
//  ps9205
//
//  Created by Jung peter on 4/2/23.
//

/*
 송도에 사는 상근이와 친구들은 송도에서 열리는 펜타포트 락 페스티벌에 가려고 한다. 올해는 맥주를 마시면서 걸어가기로 했다. 출발은 상근이네 집에서 하고, 맥주 한 박스를 들고 출발한다. 맥주 한 박스에는 맥주가 20개 들어있다. 목이 마르면 안되기 때문에 50미터에 한 병씩 마시려고 한다. 즉, 50미터를 가려면 그 직전에 맥주 한 병을 마셔야 한다.

 상근이의 집에서 페스티벌이 열리는 곳은 매우 먼 거리이다. 따라서, 맥주를 더 구매해야 할 수도 있다. 미리 인터넷으로 조사를 해보니 다행히도 맥주를 파는 편의점이 있다. 편의점에 들렸을 때, 빈 병은 버리고 새 맥주 병을 살 수 있다. 하지만, 박스에 들어있는 맥주는 20병을 넘을 수 없다. 편의점을 나선 직후에도 50미터를 가기 전에 맥주 한 병을 마셔야 한다.

 편의점, 상근이네 집, 펜타포트 락 페스티벌의 좌표가 주어진다. 상근이와 친구들이 행복하게 페스티벌에 도착할 수 있는지 구하는 프로그램을 작성하시오.
 */

/*
 문제를 봤을때 많이 헷갈렸던 문제이다.
 1. 그러면 50미터를 움직일때마다 맥주 갯수를 생각해줘야하는건가
    특히, 편의점에서 나오자마자 맥주를 하나 마신다 -> 여기서 그냥 낚인것 같다.
 2. dx, dy로 풀면서 bfs를 풀어야하는것인가?
 
 근데 만약에 1미터씩 움직엿다면, 시간초과가 났을것이다. 그렇기 때문에 그냥 일반적인 그래프를 생각해야한다.
 풀이는
 1. 락페에 한번에 갈 수 있나?
 2. 갈수 없다면, 한번에 갈 수 있는 편의점이 있는가?
 3. 있다면, 편의점에 가서 맥주를 채운다. 맥주를 채우고 또 그냥 거기서 1000 미터 안에 락페가 있나? 없다면, 편의점이 있나?
 4. 이렇게 반복해야하는 풀이이다.
 
 요즘 회사 때문에 알고리즘을 안풀었더니만,,, 바로 티가나는 남
 
 */

import Foundation

struct Coor: Hashable {
  var x: Int
  var y: Int
}

func dist(_ a: Coor, _ b: Coor) -> Int {
  return abs(a.x - b.x) + abs(a.y - b.y)
}

func bfs(start: Coor, beers: Int, festival: Coor, stores: [Coor]) {
  var beers = beers
  
  var queue: [Coor] = [start]
  var visited: Set<Coor> = [start]
  
  while !queue.isEmpty {
    let poped = queue.removeFirst()
    if dist(poped, festival) <= beers * 50 {
      print("happy")
      return
    }
    for i in 0..<stores.count {
      if !visited.contains(stores[i]) {
        if dist(poped, stores[i]) <= beers * 50 {
          queue.append(stores[i])
          visited.insert(stores[i])
        }
      }
    }
  }
  print("sad")
}

let t = Int(readLine()!)!
for _ in 0..<t {
  let n = Int(readLine()!)!
  let house = readLine()!.split(separator: " ").map { Int(String($0))!}
  var houseCoor = Coor(x: house[0], y: house[1])
  var store: [Coor] = []
  for _ in 0..<n {
    let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
    store.append(Coor(x: temp[0], y: temp[1]))
  }
  let festival = readLine()!.split(separator: " ").map { Int(String($0))!}
  var festivalCoor = Coor(x: festival[0], y: festival[1])
  var beers: Int = 20
  
  if dist(houseCoor, festivalCoor) <= beers * 50 {
    print("happy")
  } else {
    bfs(start: houseCoor, beers: beers, festival: festivalCoor, stores: store)
  }
}




