//
//  main.swift
//  1013
//
//  Created by abc on 2022/02/05.
//

import Foundation

let input = Int(readLine()!)!

for _ in 0..<input {
  let strArray = readLine()!.map {String($0)}

  var index = 0

  while true {
    
    if strArray.count < 2 {
      print("NO")
      break
    }
    
    if index == strArray.count {
      print("YES")
      break
    }

    if index < strArray.count-1 && strArray[index] == "0" {
      index += 1
      if strArray[index] == "0" {
        print("NO")
        break
      }
      index += 1
    } else if index < strArray.count-3 && strArray[index] == "1" {
      index += 1
      if let oneIndex = strArray[index..<strArray.count].firstIndex(of: "1") {
        if strArray[index...oneIndex].joined().contains("00") {
          index = oneIndex + 1
        } else {
          print("NO")
          break
        }
      } else {
       print("NO")
        break
      }
    } else {
      print("NO")
      break
    }
  }
}



//let input = Int(readLine()!)!
//let pattern = "^((100+1+)|01)+$"
//
//for _ in 0..<input {
//  let strArray = readLine()!
//  guard let _ = strArray.range(of: pattern, options: .regularExpression) else {
//    print("NO")
//    continue
//  }
//  print("YES")
//}


