//
//  main.swift
//  ps4256
//
//  Created by Jung peter on 3/2/23.
//

import Foundation

/* 문제
 BT를 전위 순회, 중위 순회한 결과가 주어진다. 즉, 위의 함수 중 preorder(root node of BT)와 inorder(root node of BT)를 호출해서 만든 리스트가 주어진다. 두 순회한 결과를 가지고 다시 BT를 만들 수 있다. BT의 전위, 중위 순회한 결과가 주어졌을 때, 후위 순회했을 때의 결과를 구하는 프로그램을 작성하시오.
 */

/* 문제 풀이
 트리 - 재귀라고 생각
 preorder는 root의 index를 알려준다.
 preorder[0]은 일단 무조건 root이다.
 inorder는 왼 중간 오 이기 때문에, 중간을 기준으로 무조건 자식트리가 존재한다.
 그래서 preorder에서 root를 찾고, inorder에서 root를 기준으로 2개의 자식트리를 구해야한다.
 그리고 2개의 자식노드에 대해서 재귀로 또 돌리면 되는것!
 preorder에서 root를 찾는 것은 부모[index]
 왼쪽 [부모 index + 1], 최상위에서 오른쪽은 [부모 index + 왼쪽트리크기 + 1 - start]
 
 ** 시간복잡도 **
 O(N)
 */


let t = Int(readLine()!)!

func postOrder(root: Int, preOrder: [Int], inOrder: [Int], start: Int, end: Int) {
  for i in start..<end {
    if preOrder[root] == inOrder[i] {
      postOrder(root: root+1, preOrder: preOrder, inOrder: inOrder, start: start, end: i)
      postOrder(root: root + i + 1 - start, preOrder: preOrder, inOrder: inOrder, start: i+1, end: end)
      print(inOrder[i])
    }
  }
}

for _ in 0..<t {
  
  let n = Int(readLine()!)!

  let preOrder = readLine()!.split(separator: " ").map { Int(String($0))!}
  let inOrder = readLine()!.split(separator: " ").map { Int(String($0))!}
  postOrder(root: 0, preOrder: preOrder, inOrder: inOrder, start: 0, end: n)

}





