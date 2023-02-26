import Foundation

func dfs(_ begin: String, _ target: String, _ words: [String], _ cnt: Int) -> Int {
    var answer = 0;
    if begin == target { return cnt }
    if words.count == 0 { return 0 }
    var words = words
  if let index = words.firstIndex(of: begin) {
    words.remove(at: index)
  }
    for word in words {
        let wordArr = word.map { String($0) }
        let beginArr = begin.map { String($0) }
        var sameCnt = 0
        zip(wordArr, beginArr).forEach {
            if $0 == $1 {
                sameCnt += 1
            }
        }
        if sameCnt == word.count - 1 {
            answer = dfs(word, target, words, cnt+1);
        }
    }
    return answer;
}

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    
    return dfs(begin, target, words, 0)
}

print(solution("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"]))
