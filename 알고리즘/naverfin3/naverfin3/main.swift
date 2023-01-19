//
//  main.swift
//  naverfin3
//
//  Created by Jung peter on 12/17/22.
//

import Foundation

struct Game: Hashable {
  var price: Int
  var date: Int
  var percent: Double
}

func solution(_ games: [[Int]]) -> Int {
  
  
  var games = games.map { Game(price: $0[0], date: $0[1], percent: Double($0[2]) / Double(100))}.sorted(by: {$0.price > $1.price})
  
  var lastday = games.max(by: { $0.date < $1.date})!.date
  
  var gamedic: [Int: [Game]] = [:]
  var resultDic: [Int: [Game]] = [:]
  for game in games {
    if gamedic[game.date] == nil {
      gamedic[game.date] = [game]
    } else {
      gamedic[game.date]! += [game]
    }
  }
  
  for game in gamedic {
    if game.value.count > 0 {
      var temp = game.value.min(by: { (Double($0.price) * $0.percent) < (Double($1.price) * $1.percent) })!
      games.remove(at: games.firstIndex(of: temp)!)
      resultDic.updateValue([], forKey: game.key)
    } else {
      games.remove
      games.remove(at: games.firstIndex(of: game.value))
    }
  }
  
  resultDic.forEach(<#T##body: ((key: Int, value: [Game])) throws -> Void##((key: Int, value: [Game])) throws -> Void#>)
    return 0
}


