import Foundation



func mergeSort(_ array: inout [Int], _ left: Int, _ right: Int){
    if(left < right){
        let mid = (left + right) / 2
        mergeSort(&array, left, mid)
        mergeSort(&array, mid+1, right)
        merge(&array, left, mid, right);
        
        // 4
        
    }
}

func merge(_ array: inout [Int], _ left: Int, _ mid: Int, _ right: Int){
    
    var i = left
    var j = mid + 1
    var aux = [Int]()
    
    var k = left;
    var arrayL = [Int]()
    var arrayR = [Int]()

    for i in left ... mid{
        arrayL.append(array[i])
    }
    for j in mid+1...right{
        arrayR.append(array[j])
    }

    var indexL = 0, indexR = 0
    while(indexL < arrayL.count &&  indexR < arrayR.count){ //2 read
        if(arrayL[indexL] <= arrayR[indexR]){
            array[k] = (arrayL[indexL]) //1write
            indexL += 1
        } else { //4
            array[k] = (arrayR[indexR]) //2write
            indexR += 1
        }
        k += 1
    }

    while(indexL < arrayL.count){ //5
        array[k] = arrayL[indexL]
        indexL += 1
        k += 1
    }
    while(indexR < arrayR.count){ //6
        array[k] = arrayR[indexR]
        indexR += 1
        k += 1
    }
}

var array = [1,100,77]

mergeSort(&array, 0, array.count - 1)
print(array)

