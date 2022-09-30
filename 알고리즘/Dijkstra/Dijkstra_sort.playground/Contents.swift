
let INF = 100000000;

var graph : [String: [(String, Int)]] = [:]
graph.updateValue([("B", 8), ("C", 1), ("D", 2)], forKey: "A")
graph.updateValue([], forKey: "B")
graph.updateValue([("B", 5), ("D", 2)], forKey: "C")
graph.updateValue([("E", 3), ("F", 5)], forKey: "D")
graph.updateValue([("F", 1)], forKey:"E")
graph.updateValue([("A", 5)], forKey: "F")

for items in graph {
    for item in items.value {
        print("\(items.key) -> \(item.0) : \(item.1)")
    }
}

print(dijkstra(graph,start: "A"))



func dijkstra(_ graph: [String: [(String, Int)]], start: String) -> [String: Int] {
    var distances : [String: Int] = [:]
    for item in graph {
        distances.updateValue(INF, forKey: item.key)
    }
    distances[start] = 0
    var pq: [(Int, String)] = [(distances[start]!, start)]
    
    while(!pq.isEmpty){
        print(pq)
        pq.sort{$0 > $1}
        let dequeued = pq.removeLast()
        
        let currentDistance = dequeued.0
        let currentNode = dequeued.1
        
        if(distances[currentNode]! < currentDistance) { // if not shortestpath pass
            continue
        }
        for (adjacent, weight) in graph[currentNode]! {
            print(pq)
            let distance = currentDistance + weight
            if distance < distances[adjacent]! {
                distances[adjacent] = distance
                pq.append((distance, adjacent))
            }
        }
    }
    return distances
}



