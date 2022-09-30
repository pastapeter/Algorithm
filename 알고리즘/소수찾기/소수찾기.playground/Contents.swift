
func solution(_ n:Int) -> Int {
    var result = 0
    var target = [Int](repeating: 0, count : n+1)
    for i in 2...n {
        target[i] = i
    }
    for i in 2...n {
        if target[i] == 0 {
            continue
        }
        var next = i + i
        while(next <= n){
            target[next] = 0
            next += i
        }
    }
    for i in target{
        if i != 0 {
            result += 1
        }
    }
    return result
}
