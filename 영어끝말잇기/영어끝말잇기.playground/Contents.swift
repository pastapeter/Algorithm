import Foundation

func tailRule(_ before: String, _ after: String) -> Bool {
    return before.last! == after.first!
}

func solution(_ n:Int, _ words:[String]) -> [Int] {
    var set = Set<String>()
    var turn = 0
    
    for index in words.indices {
        
        if index % n == 0 {
            turn += 1
        }
        set.insert(words[index])
        if set.count != index + 1 {
            return [index % n + 1 ,turn]
        }
        
        if index > 0 && tailRule(words[index-1], words[index]) == false {
            return [index % n + 1, turn]
        }
        
    }
    
    return [0,0]
}
