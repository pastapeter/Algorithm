import Foundation

func teliing()->Int{
    let input = Int(readLine()!)!
    var arr = [Int](repeating: 0, count: input+1)
    if input == 1{
        return 1
    } else {
        arr[1] = 1
        arr[2] = 3
        if input >= 3 {
            for i in 3...input{
                arr[i] = (arr[i-1] + 2*arr[i-2]) % 10007
            }
        }
    }
    return arr[input]
}

print(teliing())

