import Foundation

func combi<T>(_ nums: [T], _ targetNum: Int) -> [[T]] {
    var result = [[T]]()
    
    func combination(_ index: Int, _ nowCombi: [T]) {
        if nowCombi.count == targetNum {
            result.append(nowCombi)
            return
        }
        
        for i in index..<nums.count {
            combination(i+1, nowCombi + [nums[i]])
        }
    }
    
    combination(0, [])
    return result
}

func solution(_ orders:[String], _ course:[Int]) -> [String] {
    var answer: [String] = []
    for courseNum in course {
        var dic = [String: Int]()
        for order in orders {
            var order = order.map { String($0) }
            var candidates = combi(order, courseNum)
            for candidate in candidates {
                var candidate = candidate.sorted().joined()
                dic.updateValue((dic[candidate] ?? 0) + 1, forKey: candidate)
            }
        }
        
        guard let maxVal = dic.max(by: {$0.value < $1.value })?.value else {continue}
        
        for i in dic {
            if i.value == maxVal && i.value > 1 {
                answer.append(i.key)
            }
        }
    }
    return answer.sorted()
}


print(solution(["ABCFG", "AC", "CDE", "ACDE", "BCFG", "ACDEH"], [2,3,4]))


//import Foundation
//
//func combi<T>(_ nums: [T], _ targetNum: Int) -> [[T]] {
//    var result = [[T]]()
//
//    func combination(_ index: Int, _ nowCombi: [T]) {
//        if nowCombi.count == targetNum {
//            result.append(nowCombi)
//            return
//        }
//
//        for i in index..<nums.count {
//            combination(i+1, nowCombi + [nums[i]])
//        }
//    }
//
//    combination(0, [])
//    return result
//}
//
//func solution(_ orders:[String], _ course:[Int]) -> [String] {
//    var answer: [Set<String>] = []
//    for courseNum in course {
//        var dic = [Set<String>: Int]()
//        for order in orders {
//            var order = order.map { String($0) }
//            var candidates = combi(order, courseNum)
//            for candidate in candidates {
//                var candidate = Set(candidate)
//                dic.updateValue((dic[candidate] ?? 0) + 1, forKey: candidate)
//            }
//        }
//
//        guard let maxVal = dic.max(by: {$0.value < $1.value })?.value else {continue}
//        for i in dic {
//            if i.value == maxVal && i.value > 1 {
//                answer.append(i.key)
//            }
//        }
//    }
//    var result = answer.map {
//        return Array($0).sorted().joined()
//    }
//
//    return result.sorted()
//}
