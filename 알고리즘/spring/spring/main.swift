import Foundation


// 1
func checkNumberOfPeople(purchaser: Int, makers: Int) -> Double {
  var purchaser = purchaser + 1
  var percent = Double(makers) / Double(purchaser)
  if percent >= 1 {
    return 1
  }
  return percent
}

struct Lottery {

  var percent: Double
  var money: Int
  var index: Int
}

func solution(_ lotteries:[[Int]]) -> Int {
  var newLotteries: [Lottery] = []
  var number = 0
  for i in lotteries.indices {
    let maker = lotteries[i][0]
    let purchaser = lotteries[i][1]
    
    let money = lotteries[i][2]
    var percent = checkNumberOfPeople(purchaser: purchaser, makers: maker)
    newLotteries.append(Lottery(percent: percent, money: money, index: i+1))
    
  }
  
  newLotteries = newLotteries.sorted(by: {
    if $0.percent > $1.percent {
      return true
    } else if $0.percent == $1.percent {
      return $0.money > $1.money
    } else {
      return false
    }
  })
  
  
  return newLotteries.first!.index
}

print(solution(
  [[100, 100, 500], [1000, 1000, 100]]))
