import Foundation

// if 자동차 only 자동차
// if 자전거 구간별로 자전거 or 도보
// if 대중교통 연속해서 m분
// 번호가 작은 순서대로 sort

enum Transportation: Int, CaseIterable {
    case car
    case bike
    case bus
    case walk
}


func solution(_ infos:[[Int]], _ m:Int) -> Int {

  var durationDic = [Transportation: [Int]]()
  var totalDurationDic: [Transportation: Int] = [.car: 0, .bike: 0, .bus: 0, .walk: 0]
  durationDic = [.car: [], .bike: [], .bus: [], .walk: []]
  
  
  for info in infos {
    for i in 0..<4 {
      durationDic[Transportation.allCases[i]]!.append(info[i])
    }
  }
  
  for info in durationDic {
    
    // 자동차
    if info.key == .car {
      totalDurationDic[info.key]! = info.value.reduce(0, +)
    }
    
    //자전거
    else if info.key == .bike {
      var temp = 0
      var isWalking = 0
      for (biketime, walktime) in zip(durationDic[.bike]!, durationDic[.walk]!) {
        if biketime == -1 && walktime != -1 {
          if isWalking + walktime > m {
            temp = Int.max
            break
          }
          temp += walktime
          isWalking += walktime
        } else if walktime == -1 {
          temp += biketime
        } else {
          // 자전거가 더 느려
          if biketime > walktime && walktime + isWalking <= m {
            temp += walktime
            isWalking += walktime
          }
          // 자전거가 더 빨라
          else if biketime < walktime {
            temp += biketime
          }
          // 누가 더 빠르던 더 못걸어
          else if walktime + isWalking > m {
            temp += biketime
          }
        }
      }
      totalDurationDic[.bike]! = temp
    }
    
    // 대중교통
    else if info.key == .bus {
      var isWalking = 0
      var temp = 0
      for (bustime, walktime) in zip(durationDic[.bus]!, durationDic[.walk]!) {
        // 버스 못탐
        if bustime == -1 && walktime != -1 {
          if walktime + isWalking > m {
            temp = Int.max
            break}
          temp += walktime
          isWalking += walktime
          //걸어서 못감
        } else if walktime == -1 {
          temp += bustime
          // 둘다 가능
        } else {
          // 걸어서 못감
          if isWalking + walktime > m {
            temp += bustime
            // 걸어서 가능
          } else {
            if walktime < bustime {
              temp += walktime
              isWalking += walktime
            } else {
              temp += bustime
            }
          }
        }
      }
      totalDurationDic[.bus]! = temp
    }
    
    //걷기만 하기
    else {
      let total = durationDic[info.key]!.reduce(0, +)
      if  total > m {
        totalDurationDic[.walk]! = Int.max
      } else {
        totalDurationDic[.walk]! = total
      }
    }
  }
  
  return totalDurationDic.min(by: {$0.value < $1.value})!.value
}


