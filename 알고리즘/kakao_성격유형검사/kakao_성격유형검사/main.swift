import Foundation

func solution(_ survey:[String], _ choices:[Int]) -> String {
    var answer = ""
    let table = [1: ["R", "T"],
                 2: ["C", "F"],
                3: ["J", "M"],
                4: ["A", "N"]]
    
    var featureTable = ["R": 0, "T": 0, "C": 0, "F": 0, "J": 0, "M": 0, "A": 0, "N": 0]
    
    for i in survey.indices {
        let feature12 = survey[i].map { String($0) }
        if choices[i] < 4 {
            featureTable[feature12[0]]! += abs(choices[i] - 4)
        } else if choices[i] > 4 {
            featureTable[feature12[1]]! += choices[i]-4
        }
    }
    
    for i in 1...4 {
            if featureTable[table[i]![0]]! > featureTable[table[i]![1]]! {
                answer += "\(table[i]![0])"
            } else if featureTable[table[i]![0]]! < featureTable[table[i]![1]]! {
                answer += "\(table[i]![1])"
            } else {
                answer += "\(min(table[i]![0], table[i]![1]))"
            }
    }
    
    return answer
}


print(solution(["AN", "CF", "MJ", "RT", "NA"], [5, 3, 2, 7, 5]))
