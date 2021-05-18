
func mColoring(i: Int){
    var c: Int
    if(promising(i: i)){
        if(i == n){
            for node in 1...n{
                print(color[node])
            }
        }else {
            for c in 1...m{
                color[i+1] = c
                mColoring(i: i+1)
            }
        }
    }
}

func promising(i: Int)-> Bool {
    var j = 1
    var `switch` = true
    while(j<i && `switch`){
        if((W[i][j] != 0) && color[i] == color[j]){
            `switch` = false
        }
        j += 1
    }
    return `switch`
}

