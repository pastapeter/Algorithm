import Foundation

func getTimeInterval(_ intime: String, _ outtime: String) -> Int {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    let intimeDate = formatter.date(from: intime)!
    let outtimeDate = formatter.date(from: outtime)!
    
    return Int(outtimeDate.timeIntervalSince(intimeDate))
}

func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    
    var garage: [String: String] = [:]
    var feeDic: [String: Int] = [:]
    
    
    for record in records {
        var carInfo = record.split(separator: " ").map { String($0)}
        if carInfo[2] == "IN" {
            garage.updateValue(carInfo[0], forKey: carInfo[1])
        } else {
            var inTime = garage[carInfo[1]]!
            var interval = getTimeInterval(inTime, carInfo[0]) / 60
            feeDic.updateValue((feeDic[carInfo[1]] ?? 0) + interval, forKey: carInfo[1])
            garage.removeValue(forKey: carInfo[1])
        }
    }
    
    while !garage.isEmpty {
        for car in garage {
            var inTime = car.value
            var interval = getTimeInterval(inTime, "23:59") / 60
            feeDic.updateValue((feeDic[car.key] ?? 0) + interval, forKey: car.key)
            garage.removeValue(forKey: car.key)
        }
    }
    for feeInfo in feeDic {
        let interval = (feeInfo.value - fees[0]) > 0 ? (feeInfo.value - fees[0]) : 0
        feeDic[feeInfo.key] = fees[1] + Int(ceil(Double(interval) / Double(fees[2]))) * fees[3]
    }
    
    return feeDic.sorted(by: {$0.key < $1.key}).map { $0.value }
}


print(solution([1, 461, 1, 10],["00:00 1234 IN"]))
