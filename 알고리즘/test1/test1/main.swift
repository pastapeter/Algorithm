import Foundation

struct KakaoDate {
    
    var year: Int
    var month: Int
    var day: Int
    var hour: Int
    var min: Int
    var sec: Int
    
    func days() -> Int {
        return self.year * 360 + self.month * 30 + self.day
    }
    
    static func add(_ lhs:KakaoDate, _ rhs: (day: Int, hour: Int, min: Int, sec: Int)) -> KakaoDate {
        var lhs = lhs
        // 초
        if lhs.sec + rhs.sec > 59 {
            var temp = lhs.sec + rhs.sec
            lhs.sec = (lhs.sec + rhs.sec) % 60
            lhs.min += (temp) / 60
        } else {
            lhs.sec += rhs.sec
        }
        // 분
        if lhs.min + rhs.min > 59 {
            var temp = lhs.min + rhs.min
            lhs.min = (lhs.min + rhs.min) % 60
            lhs.hour += (temp) / 60
        } else {
            lhs.min += rhs.min
        }
        
        // 시
        if lhs.hour + rhs.hour > 23 {
            var temp = lhs.hour + rhs.hour
            lhs.hour = (lhs.hour + rhs.hour) % 24
            lhs.day += (temp) / 24
        } else {
            lhs.hour += rhs.hour
        }
        
        //일
        if lhs.day + rhs.day > 30 {
            var temp = lhs.day + rhs.day
            lhs.day = (lhs.day + rhs.day) % 30
            lhs.month += (temp) / 30
        } else {
            lhs.day += rhs.day
        }
        
        //월
        if lhs.month > 12 {
            lhs.year += lhs.month / 12
            lhs.month = lhs.month % 12
        }
        
        return lhs
    }
}


func solution(_ s:String, _ times:[String]) -> [Int] {
    let startList = s.split(separator: ":").map { Int(String($0))!}
    var start = KakaoDate(year: startList[0], month: startList[1], day: startList[2], hour: startList[3], min: startList[4], sec: startList[5])
    var dateArr: [KakaoDate] = [start]
    
    for time in times {
        var timeList = time.split(separator: ":").map { Int(String($0))!}
        start = KakaoDate.add(start, (day: timeList[0], hour: timeList[1], min: timeList[2], sec: timeList[3]))
        dateArr.append(start)
    }
    
    var timeIntervalArr: [Int] = []
    timeIntervalArr = dateArr.map { $0.days()}
    
    let duration = timeIntervalArr.last! - timeIntervalArr.first!
    var flag = 1
    for i in 1..<timeIntervalArr.count {
        if timeIntervalArr[i] - timeIntervalArr[i-1] > 1 {
            flag = 0
            break
        }
    }
    
    return [flag,duration + 1]
}

