var INF = 999
var adjMat : [[Int]] = [[0, 29, INF, INF, INF, 10, INF],
                         [29, 0, 16, INF, INF, INF, 15],
                         [INF, 16, 0, 12, INF, INF, INF],
                         [INF, INF, 12, 0, 22, INF, 18],
                         [INF, INF, INF, 22, 0, 27, 25],
                         [10, INF, INF, INF, 27, 0, INF],
                         [INF, 15, INF, 18, 25, INF, 0]]

var nodeNum = adjMat.count
var visited = [Bool](repeating: false, count: nodeNum)
var distance = [Int](repeating: INF, count: nodeNum)

func getMinNode(_ num: Int) -> Int{
    var v = 0
    for i in 0..<num {
        if !visited[i] {
            v = i
            break
        }
    }
    print("아직 방문하지 않은 v: ", v)
    for i in 0..<num {
        if !visited[i] && (distance[i] < distance[v]){
            v = i
        }
    }
    return v
}

func getSmallIndex(_ number: Int) -> Int {
    var min = INF
    var index = 0
    for i in 0..<number {
        if(distance[i] < min && !visited[i]){
            min = distance[i]
            index = i
        }
    }
    return index
}

func prim(_ start: Int, _ nodeNUm: Int){
    distance[start] = 0
    for i in 0..<nodeNum {
        var node = getSmallIndex(nodeNum)
        visited[node] = true
        for j in 0..<nodeNum{
            if adjMat[node][j] != INF{
                if !visited[j] && (adjMat[node][j] < distance[j]) {
                    distance[j] = adjMat[node][j]
                }
            }
        }
    }
}
prim(0,7)
print("distance ", distance)
print("ㄱㅓ리: ", distance.reduce(0,+))
