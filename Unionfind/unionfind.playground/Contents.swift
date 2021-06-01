import Cocoa

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

var parent = [Int](repeating: 1, count: 11)
parent[0] = 0
for i in 1..<parent.count{
    parent[i] = i
}
print(parent)
unionParent(parent: &parent, a: 1, b: 2)
print(parent)
unionParent(parent: &parent, a: 2, b: 3)
print(parent)
unionParent(parent: &parent, a: 3, b: 4)
print(parent)
unionParent(parent: &parent, a: 5, b: 6)
print(parent)
unionParent(parent: &parent, a: 6, b: 7)
print(parent)
unionParent(parent: &parent, a: 7, b: 8)
print(parent)

print("1 - 5 are connected?", findParent(parent: &parent, a: 1, b: 5))
unionParent(parent: &parent, a: 1, b: 5)
print("1 - 5 are connected?", findParent(parent: &parent, a: 1, b: 5))


