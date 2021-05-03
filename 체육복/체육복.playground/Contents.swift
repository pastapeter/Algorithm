

import Foundation

func solution(_ n:Int, _ lost:[Int], _ reserve:[Int]) -> Int {
    var newlost = lost;
    var newReserve = reserve;
//      var losted = lost.filter{!reserve.contains($0)}
//      var reserved = reserve.filter{!lost.contains($0)}
    // filter로 중복삭제
    for i in newReserve{
        if (newlost.contains(i)){
            newReserve.remove(at: newReserve.firstIndex(of:i)!)
            newlost.remove(at: newlost.firstIndex(of: i)!)
        }
    }
    for i in newlost {
        if (newReserve.contains(i-1) && i>0){
            newlost.remove(at: newlost.firstIndex(of: i)!)
            newReserve.remove(at: newReserve.firstIndex(of:i-1)!)
        } else if (newReserve.contains(i+1) && i<n){
            newlost.remove(at: newlost.firstIndex(of: i)!)
            newReserve.remove(at: newReserve.firstIndex(of:i+1)!)
        }
    }
    return n - newlost.count
}

