//1. Construct your tree using your own programming language and perform BFS from root
//
//2. Construct your tree using your own programming language and perform DFS from root
//


class Tree {
    var data: Int
    var left: Tree?
    var right: Tree?
    init(_ data: Int, _ left: Tree? = nil, _ right: Tree? = nil) {
        self.data = data
        self.left = left
        self.right = right
    }
}

var node1 = Tree(5)
var node2 = Tree(6)
var node3 = Tree(3, node1, node2)
var node4 = Tree(1)
var node5 = Tree(4, node3, node4)
var node6 = Tree(2)
var node7 = Tree(7)
var node8 = Tree(9, node6, node7)
var node9 = Tree(10, node5, node8)

//BFS
func BFS()->[Int]{
    var queue = [Tree]()
    queue.append(node9)
    var visited = [Int]()
    while(!queue.isEmpty){
        let dequeued = queue.removeFirst()
        visited.append(dequeued.data)
        if let leftTree = dequeued.left {
            queue.append(leftTree)
        }
        if let rightTree = dequeued.right {
            queue.append(rightTree)
        }
    }
    return visited
}

print(BFS())

//DFS
func DFS(_ root: Tree?){
    if let root = root {
        print(root.data)
    } else { return }
    DFS(root?.left)
    DFS(root?.right)
}

DFS(node9)

//3. Explain how you would do BFS and DFS on general graph
//
//      - explain how you would read the input and how you keep the data
//
//      - explain how you are going to implement BFS, DFS , and how it is different from (1, 2)
//BFS on general graph is smiliar with BFS on tree, it uses the queue. But BFS on tree can be done from the root to leaf node. But graph has no root or leaf, and when the graph is cycle, you can revisit the vertex if you don't check the vertex that has been visited. So you should manage the list that store the visited vertexes. so the code will be like this

let graph: [String: [String]] = [
    "A" : ["B", "C"],
    "B" : ["A", "D", "E"],
    "C" : ["A", "F"],
    "D" : ["B", "E"],
    "E" : ["B", "D"],
    "F" : ["C"],
]


func BFSgraph(graph: [String: [String]], start: String) -> [String] {
    var visitedQueue: [String] = []
    var needToVisit: [String] = [start]
    
    while !needToVisit.isEmpty {
        let node: String = needToVisit.removeFirst()
        if visitedQueue.contains(node) {continue} //this is only for graph because indirected graph can go any direction when there is edge. So this means that if i visited this vertex, i can skip this one.
        visitedQueue.append(node)
        needToVisit += graph[node] ?? [] // when you visit the node there is adjacent nodes, so this code means that enqueue the adjacent nodes into needTovisit
    }
    return visitedQueue
}


print("BFSgraph : ", BFSgraph(graph: graph, start: "E"))

//dfs
// you can make dfs with Stack or recursive way. So why stack? This is because, when you go deep through graph, you may find the vertext that end, like the leaf node in Tree. So, you go back to the before node if it has other edges. This is the reason why we should use Stack. We should pop the element, and use just before. And You should use the list that store the visited one. This is big different with the DFS on tree. Tree goes the same way, from root to leaf. But the graph does not. So you should store visited one not to visit them. SO the source code would be like this

func DFSgraph(graph: [String: [String]], start: String) -> [String] {
    var visited: [String] = []
    var needToVisit: [String] = [start]
    
    while !needToVisit.isEmpty {
        let node: String = needToVisit.removeLast()
        if visited.contains(node){continue}
        
        visited.append(node)
        needToVisit += graph[node] ?? []
    }
    return visited
}

print("DFSgraph : ", DFSgraph(graph: graph, start: "E"))
print("DFSgraph : ", DFSgraph(graph: graph, start: "A"))

//recursive way, if you use stack, you can also use recursive.
func DFSrecursive(start: String){
    var visited = [String]()
    dfs(startvartex: start, visited: &visited)
}
func dfs(startvartex: String, visited: inout [String]){
    visited.append(startvartex)
    print(startvartex)
    guard let adjc = graph[startvartex] else{
        return
    }
    for vertex in adjc {
        if !visited.contains(vertex) {
            dfs(startvartex: vertex, visited: &visited)
        }
    }
}

DFSrecursive(start: "A")
