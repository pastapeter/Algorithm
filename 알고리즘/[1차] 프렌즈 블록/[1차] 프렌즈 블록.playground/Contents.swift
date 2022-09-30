
func solution(_ m:Int, _ n:Int, _ board:[String]) -> Int {
  
  var contentBoard = board.map{Array($0).map{String($0)}}
  var completeFlag = true
  var stackBoard = [[String]]()
  var count = 0
  
  //stackboard 로
  for i in 0..<n {
    var arr = [String]()
    for j in 0..<m {
      arr.append(contentBoard[j][i])
    }
    stackBoard.append(arr)
  }
  
  while true {
    completeFlag = true
    for yIndex in 0..<m-1 {
      for xIndex in 0..<n-1 {
        
        let first = (yIndex, xIndex)
        let second = (yIndex,  xIndex + 1)
        let third = (yIndex + 1, xIndex)
        let fourth = (yIndex + 1, xIndex + 1)
        
        if Set([contentBoard[first.0][first.1], contentBoard[second.0][second.1], contentBoard[third.0][third.1], contentBoard[fourth.0][fourth.1]]).count == 1 && contentBoard[first.0][first.1] != "0"{
          stackBoard[first.1][first.0] = "1"
          stackBoard[second.1][second.0] = "1"
          stackBoard[third.1][third.0] = "1"
          stackBoard[fourth.1][fourth.0] = "1"
          completeFlag = false
        }
      }
    }
    
    for index in stackBoard.indices {
      stackBoard[index].removeAll(where: {$0 == "1"})
      let blank = m - stackBoard[index].count
      let arr = [String](repeating: "0", count: blank)
      stackBoard[index].insert(contentsOf: arr, at: 0)
    }
    
    for i in 0..<n {
      for j in 0..<m {
        contentBoard[j][i] = String(stackBoard[i][j])
      }
    }
    
    if completeFlag == true {
      break
    }
    
  }
  
  for index in contentBoard.indices {
    let arrCount = contentBoard[index].count
    contentBoard[index].removeAll(where: {$0 == "0"})
    count += arrCount - contentBoard[index].count
  }
  
  
  return count
}
