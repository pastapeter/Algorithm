//
//  main.swift
//  ps1759
//
//  Created by Jung peter on 3/3/23.
//

import Foundation

/*
 바로 어제 최백준 조교가 방 열쇠를 주머니에 넣은 채 깜빡하고 서울로 가 버리는 황당한 상황에 직면한 조교들은, 702호에 새로운 보안 시스템을 설치하기로 하였다. 이 보안 시스템은 열쇠가 아닌 암호로 동작하게 되어 있는 시스템이다.

 암호는 서로 다른 L개의 알파벳 소문자들로 구성되며 최소 한 개의 모음(a, e, i, o, u)과 최소 두 개의 자음으로 구성되어 있다고 알려져 있다. 또한 정렬된 문자열을 선호하는 조교들의 성향으로 미루어 보아 암호를 이루는 알파벳이 암호에서 증가하는 순서로 배열되었을 것이라고 추측된다. 즉, abc는 가능성이 있는 암호이지만 bac는 그렇지 않다.

 새 보안 시스템에서 조교들이 암호로 사용했을 법한 문자의 종류는 C가지가 있다고 한다. 이 알파벳을 입수한 민식, 영식 형제는 조교들의 방에 침투하기 위해 암호를 추측해 보려고 한다. C개의 문자들이 모두 주어졌을 때, 가능성 있는 암호들을 모두 구하는 프로그램을 작성하시오.

 */

/*
 풀이
 일단 처음에 다른 L개의 알파벳 소문자들로 구성되며 최소 한 개의 모음(a, e, i, o, u)과 최소 두 개의 자음으로 구성 이 문장을 생각하지 않고 풀어서 한번 틀렸다...
 근데 이미 풀어놓은게 있어서 다시 엎어야하는 상황에서 그냥
 서로다른이기 때문에 set으로 조건을 맞춰주었다.
 
 백트래킹은 다음과같다.
 빈배열에 하나씩 넣어주는데, 넣고, 백트래킹, 빼고이다.
 start를 인자를 tracking하면서 다음 넣고의 인덱스를 계속 정해준다.
 */

let lc = readLine()!.split(separator: " ").map { Int(String($0))!}
let l = lc[0]
let c = lc[1]
let a = readLine()!.split(separator: " ").map { String($0)}.sorted()

var ans: [[String]] = []

//백트래킹을 활용하여 모든 경우의 수를 구한다.
func backtracking(depth: Int,start: Int, substring: inout [String]) {
  
  if depth == l {
    ans.append(substring)
    return
  }
  
  //끝까지 도는데
  for i in 0..<c {
    //start+i 그니깐 재귀함수의 첫번째 인덱스부터 하나씩 나아가면서,
    // c보다 크거나 같으면 continue
    if (start + i) >= c { continue }
    //그리고 해당알파벳을 뒤에 넣어주고
    substring.append(a[start+i])
    // 백트래킹 시작
    backtracking(depth: depth+1, start: start+i+1, substring: &substring)
    //백트래킹 끝나면 해당 알파벳을 다시 빼준다.
    substring.removeLast()
  }
  
}

var substring: [String] = []
backtracking(depth: 0, start: 0, substring: &substring)
let alphset: Set<String> = ["a", "e", "i", "o", "u"]
// 모음이 최소1개
ans = ans.filter { Set($0).intersection(alphset).count >= 1 }
// 자음이 최소 2개
ans = ans.filter { Set($0).subtracting(alphset).count >= 2 }
ans.forEach { print($0.joined()) }
