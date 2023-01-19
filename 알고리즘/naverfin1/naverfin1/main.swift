import Foundation

func permutation<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    if array.count < n { return result }

    var stack: [([T], [Bool])] = array.enumerated().map {
        var visited = Array(repeating: false, count: array.count)
        visited[$0.offset] = true
        return ([$0.element], visited)
    }
    
    while stack.count > 0 {
        let now = stack.removeLast()
        
        let elements = now.0
        var visited = now.1
        
        if elements.count == n {
            result.append(elements)
            continue
        }
        
        for i in 0...array.count-1 {
            if visited[i] { continue }
            visited[i] = true
            stack.append((elements + [array[i]], visited))
            visited[i] = false
        }
    }
    
    return result
}

func solution(_ a: [Int64]) -> Int64 {
  
  var maxInt = Int64.min
  var n = a.count
  var newa = a.map { return abs($0)}
  var limit = newa.reduce(0, +)
  var permutations = permutation(a, n)
  
  for permutation in permutations {
    var newPermutation = permutation
    var temp = 0
    for i in 1..<newPermutation.count {
      newPermutation[n-i-1] = newPermutation[n-i-1] - newPermutation[n-i]
    }
    maxInt = max(maxInt, newPermutation[0])
    if maxInt == limit { break }
  }
  return maxInt
}


