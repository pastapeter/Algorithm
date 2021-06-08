import Cocoa

let INF = Int.max
let vertexN = 7

var graph : [Int: [(Int, Int)]] = [:] //(vertex, weight)
graph.updateValue([(2,6), (3,5), (4,5)], forKey: 1)
graph.updateValue([(5,-1)], forKey: 2)
graph.updateValue([(5,1)], forKey: 3)
graph.updateValue([(3, -2), (6, -1)], forKey: 4)
graph.updateValue([(7,3)], forKey: 5)
graph.updateValue([(7,3)], forKey: 6)

var edgeList = [(Int, Int, Int)]()
var dist = [Int](repeating: INF, count: vertexN+1)
//print(dist)
for item in graph{
    for value in item.value{
        edgeList.append((item.key, value.0, value.1))
    }
}

func bellmanFord(_ start: Int)->Bool{
    dist[start] = 0
    //전체 n라운드 실시
    for i in 0..<vertexN{
        for j in 0..<edgeList.count{
            let current = edgeList[j].0
            let next = edgeList[j].1
            let weight = edgeList[j].2
            if(dist[current] != INF && dist[next] > dist[current]+weight){
                dist[next] = dist[current]+weight
                if i == vertexN-1 {
                    return true
                }
            }
        }
    }
    return false
}

var negativeCycle = bellmanFord(1)

print(dist)

