import Foundation

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    var wholeStage = Double(stages.count)
    var failDic = [Int:Double]()
    var result = [Int]()
    for i in 1...N {
        if(wholeStage != 0){
            let failure = Double(stages.filter{$0 == i}.count)
            failDic.updateValue(failure/wholeStage, forKey: i)
            wholeStage -= failure
        } else {
            failDic.updateValue(0, forKey: i)
        }
    }
    for i in failDic.sorted(by: {$0.1  == $1.1 ? $0.0 < $1.0 : $0.1 > $1.1}){
        result.append(i.key)
    }
    return result
}





