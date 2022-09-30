import Cocoa


//Kruskal Algorithm
//MST
//UNION FIND
func getParent(parent: inout [Int], x: Int) -> Int{
    if parent[x] == x {
        return x
    }
    parent[x] = getParent(parent: &parent, x: parent[x])
    return parent[x]
}

//
func unionParent(parent: inout [Int], a: Int, b: Int){
    var a = a
    var b = b
    a = getParent(parent: &parent, x: a);
    b = getParent(parent: &parent, x: b);
    if(a < b) {
        parent[b] = a
    }
    else {parent[a] = b}
}


// do you have same parent? -> Are you in same Graph
func findParent(parent: inout [Int], a: Int, b: Int) -> Bool {
    var a = a
    var b = b
    a = getParent(parent: &parent, x: a)
    b = getParent(parent: &parent, x: b)
    if(a == b){return true}
    return false
}

// edge clss
class Edge{
    var node = [Int]()
    var distance : Int
    init(a: Int, b: Int, distance: Int){
        self.node.append(a)
        self.node.append(b)
        self.distance = distance
    }
}

let n = 7
let m = 11

var EdgeList = [Edge]()
EdgeList.append(Edge(a: 1, b: 7, distance: 12))
EdgeList.append(Edge(a: 1, b: 4, distance: 28))
EdgeList.append(Edge(a: 1, b: 2, distance: 67))
EdgeList.append(Edge(a: 1, b: 5, distance: 17))
EdgeList.append(Edge(a: 2, b: 4, distance: 24))
EdgeList.append(Edge(a: 2, b: 5, distance: 62))
EdgeList.append(Edge(a: 3, b: 5, distance: 20))
EdgeList.append(Edge(a: 3, b: 6, distance: 37))
EdgeList.append(Edge(a: 4, b: 7, distance: 13))
EdgeList.append(Edge(a: 5, b: 6, distance: 45))
EdgeList.append(Edge(a: 5, b: 7, distance: 73))

//  sort ascending order
EdgeList.sort(by: {$0.distance < $1.distance})

//  store the parent of vartexs
var parent = [Int](repeating: 0, count: n)
for i in 0..<n {
    parent[i] = i
}
var sum = 0
for i in 0..<EdgeList.count{
    if(!findParent(parent: &parent, a: EdgeList[i].node[0] - 1, b: EdgeList[i].node[1] - 1)){
        sum += EdgeList[i].distance
        unionParent(parent: &parent, a: EdgeList[i].node[0] - 1, b: EdgeList[i].node[1] - 1)
    }
}
print(sum)



