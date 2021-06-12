import Cocoa

var n = 10
var children = ["c1":3.5, "c2": 4.5, "c3": 6, "c4":7, "c5":3.4, "c6":5.6, "c7":7.8, "c8":9, "c9":8.8, "c10":2.6]
var groups = [Int: [String]]()
let sortedChildren = children.sorted(by: {$0.1 < $1.1})

var first = sortedChildren[0].1
var index = 1
var group = [String]()
for child in sortedChildren {
    if first+1 >= child.1 && child.1 >= first {
        group.append(child.0)
    } else{
        first = child.1
        groups.updateValue(group, forKey: index)
        index += 1
        group.removeAll()
        group.append(child.0)
    }
}
groups.updateValue(group, forKey: index)

print(groups)



