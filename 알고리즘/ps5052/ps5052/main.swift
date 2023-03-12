//
//  main.swift
//  ps5052
//
//  Created by Jung peter on 3/12/23.
//

/*
 전화번호 목록이 주어진다. 이때, 이 목록이 일관성이 있는지 없는지를 구하는 프로그램을 작성하시오.

 전화번호 목록이 일관성을 유지하려면, 한 번호가 다른 번호의 접두어인 경우가 없어야 한다.

 예를 들어, 전화번호 목록이 아래와 같은 경우를 생각해보자

 긴급전화: 911
 상근: 97 625 999
 선영: 91 12 54 26
 이 경우에 선영이에게 전화를 걸 수 있는 방법이 없다. 전화기를 들고 선영이 번호의 처음 세 자리를 누르는 순간 바로 긴급전화가 걸리기 때문이다. 따라서, 이 목록은 일관성이 없는 목록이다.
 */

/*
 <풀이>
 사실 hasPrefix를 쓸 수 있지만, 이번에는 Trie 자료구조를 쓴 것이다.
 근데 Trie 사용하면 시간초과나는데,, 왜그런지 사실 잘 모르겟다.
 이문제에서 Trie를 쓸때 중요한점은 중간에 현재 전화번호가 있는지 확인하는 것이니, 하나의 전화번호가 들어왔을때, 노드 방문시 isTerminated 가 있으면 그때 return을 시켜주면된다.
 그렇게 하기 위해서는 전화번호 짧은 순서대로 자료구조에 삽입해야한다.
 */

/*
 hasPrefix를 쓴 경우, 다 모은다 -> sort를 한다.
 양싸이드에 대해서 hasPrefix를 검사해주면 그만!
 */

import Foundation

class TrieNode<T: Hashable> {
  var value: T?
  weak var parent: TrieNode?
  var children: [T:TrieNode] = [:]
  var isTerminating = false
  
  init(value: T? = nil, parent: TrieNode? = nil) {
    self.value = value
    self.parent = parent
  }
  
  func add(child: T) {
    guard children[child] == nil else {return}
    children[child] = TrieNode(value: child, parent: self)
  }
}

class Trie {
  typealias Node = TrieNode<Int>
  fileprivate let root: Node
  init() { root = Node()}
}

extension Trie {
  func insert(_ content: String) {
    guard !content.isEmpty else {return}
    var currentNode = root
    
    let contents = content.map { Int(String($0))!}
    var currentIndex = 0
    
    while currentIndex < contents.count {
      let ele = contents[currentIndex]
      if let child = currentNode.children[ele] {
        currentNode = child
      } else {
        currentNode.add(child: ele)
        currentNode = currentNode.children[ele]!
      }
      currentIndex += 1
      if currentIndex == contents.count {
        currentNode.isTerminating = true
      }
    }
  
  }
  
  func contain(_ content: String) -> Bool {
    guard !content.isEmpty else {return false}
    var currentNode = root
    let contents = content.map { Int(String($0))!}
    var currentIndex = 0
    while currentIndex < contents.count, let child = currentNode.children[contents[currentIndex]] {
      if child.isTerminating == true {
        return true
      }
      currentIndex += 1
      currentNode = child
    }
    if currentIndex == contents.count && currentNode.isTerminating {
      return true
    } else {return false}
  }
}

let t = Int(readLine()!)!

func solve(inputs: [String]) {
  var trie = Trie()
  for input in inputs {
    if trie.contain(input) == false {
      trie.insert(input)
    } else {
      print("NO")
      return
    }
  }
  print("YES")
}

for _ in 0..<t {
  let n = Int(readLine()!)!
  var temp: [String] = []
  for _ in 0..<n {
    temp.append(readLine()!)
  }
  temp = temp.sorted(by: { $0.count < $1.count })
  solve(inputs: temp)
}

func solution(_ turn: Int) -> String {
  let count =  Int(readLine()!)!
  var arr = [String]()
  for _ in 0..<count {
    arr.append(readLine()!)
  }
  arr.sort()
  for i in 0..<count-1 {
    if arr[i+1].hasPrefix(arr[i]) {
        return "NO"
    }
  }
  return "YES"
}

var answer = [String]()
for i in 0..<t {
  answer.append(solution(i))
}
for answer in answer {
  print(answer)
}

