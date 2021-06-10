import Cocoa



var stuffs :[(Int, Int)] = [(5, 50), (10,60), (20,140)]
var limit = 30
var result = [Float]()
var index = 0
stuffs.sort(by: {($0.1 / $0.0) > ($1.1 / $1.0)})

for i in 0..<stuffs.count{
    if limit == 0{
        break;
    }
    if stuffs[i].0 <= limit {
        limit -= stuffs[i].0
        result.append(Float(stuffs[i].1))
    } else {
        var x = Float(limit) / Float(stuffs[i].0)
        limit -= Int(Float(stuffs[i].0) * Float(x))
        result.append(Float(stuffs[i].1) * x)
    }
}
print(result)

