import Foundation

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    if !words.contains(target) {
        return 0
    }
    
    var queue = [(begin, 0)]
    var visited = [String]()
    while !queue.isEmpty {
        let dequeued = queue.removeFirst()
        visited.append(dequeued.0)
        for word in words{
            if !visited.contains(word){
                if isSimiliar(dequeued.0, word){
                    if word == target {
                        return dequeued.1+1
                    }
                    queue.append((word, dequeued.1+1))
                }
            }
        }
        
    }
    return 0
}

func isSimiliar(_ word1: String, _ word2: String) -> Bool {
    var count = 0
    let word1List = Array(word1)
    let word2List = Array(word2)
    
    for i in 0..<word1List.count{
        if word1List[i] != word2List[i]{
            count += 1
        }
    }
    
    if count > 1{
        return false
    }
    return true
}

print(solution("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"]))
