import Foundation

// dict 4개

var langDic = [String: [Int]]()
var positionDic = [String: [Int]]()
var juniorDic = [String: [Int]]()
var foodDic = [String: [Int]]()
var dicArray = [langDic, positionDic, juniorDic, foodDic]

func solution(_ info:[String], _ query:[String]) -> [Int] {
    var infoTable = [[String]]()
    var result = [Int]()
    for (index, person)  in info.enumerated() {
      var infos = person.components(separatedBy: " ").map{ String($0)}
      infoTable.append(infos)
      for i in 0..<infos.count - 1 {
        var indexArr = dicArray[i][infos[i]] ?? []
        indexArr.append(index)
        dicArray[i].updateValue(indexArr, forKey: infos[i])
      }
    }
    
    for q in query {
        var temp = q.split(separator: " ")
        temp.removeAll(where: { $0 == "and"})
        result.append(and(infoTable, String(temp[0]), String(temp[1]), String(temp[2]), String(temp[3]), String(temp[4])))
    }
    
    return result
}

func and(_ infoTable: [[String]], _ lang: String, _ position: String, _ term: String, _ food: String, _ score: String) -> Int {
    var index = Set<Int>()
    var count = 0
    
    if lang != "-" {
        index = Set(dicArray[0][lang] ?? [])
    } else {
        let java = dicArray[0]["java"] ?? []
        let python = dicArray[0]["python"] ?? []
        let cpp = dicArray[0]["cpp"] ?? []
        index = Set(java + python + cpp)
    }
    print(index)
    
    let pDic = dicArray[1][position] ?? []
    let tDic = dicArray[2][term] ?? []
    let fDic = dicArray[3][food] ?? []
    
    if position != "-" {
//        for i in pDic {
//            guard let removeIndex = index.firstIndex(of: i) else {continue}
//            index.remove(at: removeIndex)
//        }
      index = index.intersection(Set(pDic))
    }
    
    if term != "-" {
//        for i in tDic {
//            guard let removeIndex = index.firstIndex(of: i) else {continue}
//            index.remove(at: removeIndex)
//        }
      index = index.intersection(Set(tDic))
    }
    
    if food != "-" {
//        for i in fDic {
//            guard let removeIndex = index.firstIndex(of: i) else {continue}
//            index.remove(at: removeIndex)
//        }
      index = index.intersection(Set(fDic))
    }
    
    for i in index {
        if Int(infoTable[i][4])! >= Int(score)! {
            count += 1
        }
    }
    
    
    return count
}

