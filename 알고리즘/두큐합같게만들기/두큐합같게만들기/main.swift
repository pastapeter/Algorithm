import Foundation

func solution(_ queue1:[Int], _ queue2:[Int]) -> Int {
  
  var queue1sum = queue1.reduce(0, +)
  var queue2sum = queue2.reduce(0, +)
  let sumlen = queue1.count + queue2.count
  let sumQueue = queue1 + queue2
  
  var sum = queue1sum + queue2sum
  
  if sum % 2 != 0 {
    return -1
  }
  
  if queue1sum == queue2sum {
    return 0
  }
  
  var start = 0
  var end = queue1.count
  var answer = 0
  
  while start < sumlen && end < sumlen {
    if queue1sum < sum/2 {
      queue1sum += sumQueue[end]
      end += 1
    } else if queue1sum > sum/2{
      queue1sum -= sumQueue[start]
      start += 1
    } else {
      break
    }
    answer += 1
  }
  
  if queue1sum != sum / 2 {
         return -1
     }

    return answer
}


print(solution([3, 2, 7, 2], [4, 6, 5, 1]))
