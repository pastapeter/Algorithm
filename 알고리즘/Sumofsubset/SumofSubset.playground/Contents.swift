let S = [3,4,7,6]
var w = 10
var result = [Int](repeating: 0, count: S.count)
var total = S.reduce(0){($0 + $1)}
var weight = 0
var index = 0

func promising(total: Int, weight: Int, index: Int) -> Bool {
    if((weight+total >= w) && ((weight == w) || (weight + S[index+1] <= w))){
        return true
    }
    return false
    
}

func sumOfData(total: Int, weight: Int, index: Int){
    if(promising(total: total, weight: weight, index: index)){
        if(weight == w){
            print(result)
        }
        else{
            result[index+1] = S[index+1]
            sumOfData(total: total-S[index+1], weight: weight+S[index+1], index: index+1)
            result[index+1] = 0
            sumOfData(total: total-S[index+1], weight: weight, index: index+1)
        }
    }
}

sumOfData(total: total, weight: 0, index: -1)
