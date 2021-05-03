import Foundation

//var arr = [3,1,3,5,3,4,3,11,3,6]
//

//func threeWayQuicksort(array : [Int]) -> [Int]{
//    guard array.count > 1 else {
//        return array
//    }
//          var pivot = array[0]
//        let less = array.filter { $0 < pivot }
//        let middle = array.filter { $0 == pivot }
//        let greater = array.filter { $0 > pivot }
//
//    return threeWayQuicksort(array: less) + middle + threeWayQuicksort(array: greater)
//}
//print(threeWayQuicksort(array: arr))
//
//

//  3 way partition
//func threeWayQuicksort2(_ array: inout [Int], left: Int, right: Int){
//    if(left > right) {
//        return
//    }
//    let v = array[left] // pivot
//    var lt = left
//    var i = left
//    var gt = right
//    while(i<=gt){
//        if(v > array[i]) {
//            array.swapAt(i, lt)
//            i += 1
//            lt += 1
//        } else if (v < array[i]){
//            array.swapAt(i, gt)
//            gt -= 1
//        } else {
//            i += 1
//            }
//    }
//    threeWayQuicksort2(&array, left: left, right: lt-1)
//    threeWayQuicksort2(&array, left: gt+1, right: right)
//}
//
//threeWayQuicksort2(&arr, left: 0, right: arr.count - 1)
//print(arr)


func minNumCoin(money: Int, n: Int)->Int{
    let coin = [1,5,6]
   
    if money == 0 {
        return 1
    } else if (money>0 ) {
        return money
    } else {
        
    }
}
var n = 3
print(minNumCoin(money: 9, n: n))
