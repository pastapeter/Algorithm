let R = 6
var a = ["d","a","c","f","f","b","d","b","f","b","e","a"]
var aux = [String](repeating: "a", count: a.count)
var idx = ["a":0, "b":1, "c":2, "d":3, "e":4, "f":5, "-":6]
var count = [Int](repeating: 0, count: R+1)
var N = a.count

for i in 0..<a.count{
    count[idx[a[i]]!+1] += 1
}
for i in 0..<count.count-1{
    count[i+1] += count[i]
}
for i in 0..<N{
    var index = count[idx[a[i]]!]
    aux[index] = a[i]
    count[idx[a[i]]!] += 1
}
for i in 0..<aux.count{
    a[i] = aux[i]
}
print(aux)
