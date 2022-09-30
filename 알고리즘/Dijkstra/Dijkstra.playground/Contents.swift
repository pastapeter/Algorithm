
let number = 6
let INF = 10000000

var g : [[Int]] = [[0,2,5,1,INF,INF],[2,0,3,2,INF,INF],[5,3,0,3,1,5], [1,2,3,0,1,INF],[INF,INF,1,1,0,2],[INF, INF, 5,INF,2,0]]
var visited = [Bool](repeating: false, count: 6)
var distance = [Int](repeating: 0, count: 6)

// return the mininum vartex
func getSmallIndex() -> Int {
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

func dijkstra(start: Int){
    for i in 0..<number {
        distance[i] = g[start][i]
    }
    visited[start] = true
    for _ in 0..<number - 2 {
        let current = getSmallIndex()
        visited[current] = true
        for j in 0..<6 {
            if(!visited[j]){
                if(distance[current]+g[current][j] < distance[j]){
                    distance[j] = distance[current] + g[current][j]
                }
            }
        }
    }
}

var start = 0
dijkstra(start: start)
print(distance)

