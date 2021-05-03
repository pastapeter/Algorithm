import Foundation

func mergeSort(_ array: inout [Int], _ left: Int, _ right: Int){
    let r = right
    var x = left
    var y = 0
    var k = 0
    var size = 2

    while(size <= r+1){  //size는 무조건 전체배열의 길이와 같을때 까지 돌린다.
        while(x+size <= r+1){ // 여기서 x는 잘린 배열의 left값과 같다. 따라서 left값의 size을 더했을때, 전체 배열 길이를 넘지만 않으면 된다.
            merge(&array, x, (2*x+size-1) / 2, x + size - 1 ) //
            print("left \(x), mid \((2*x+size-1) / 2), right \(x + size - 1) size \(size)")
            y = x + size - 1 //merge한 배열의 right 값이다.
            k = x // merge한 배열의 left 값이다.
            x = x + size // 다음 배열 2개를 merge하기 위해서 x를 더해준다.
        }
        size = size * 2 //병합은 기본적으로 처음에는 1->2 / 2->4 / 4->8 ... 이런식으로 돌아간다.
        x=left // size 변경시 처음은 원래 배열의 left에서 시작해야하므로 x 값을 초기화한다.
        if(size/2 == r+1){ // 이것은 size가 배열과 딱 떨어질때 예를 들어 2 4 8 16 배열일때 다 merge 했다면 break;를 건다.
            break
        }
        else if(y != r){ // 병합을 할때 마지막병합이 전체배열의 r과 다르다면! 이말은 결국 꼬랑지 배열이 남는다는 소리이다. 이때는 그냥 뒷 배열에 merge 시킨다.
            merge(&array, k, y, r);
        }
    }
}

func merge(_ array: inout [Int], _ left: Int, _ mid: Int, _ right: Int){


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


var arr = [1,90,3,88,66,33,2,78,54,12,21,4,35,11]
mergeSort(&arr, 0, arr.count - 1)
print(arr);
