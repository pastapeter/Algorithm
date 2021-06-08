import Cocoa

let num = 4;
let INF = 1000000

var graph : [[Int]] = [
    [0, 5, INF, 8],
    [7, 0, 9, INF],
    [2, INF, 0, 4],
    [INF, INF, 3, 0]
]

func floydSPT(){
    //결과 그래프 초기화
    var result = [[Int]](repeating: [0,0,0,0], count: num)
    for i in 0..<graph.count{
        for j in 0..<graph[i].count{
            result[i][j] = graph[i][j]
        }
    }
//    mid = 거쳐가는 vertex, from은 출발, to는 도착
    for mid in 0..<num{
        for from in 0..<num{
            for to in 0..<num{
                if (result[from][mid] + result[mid][to]) < result[from][to]
                {
                    result[from][to] = result[from][mid]+result[mid][to]
                }
            }
        }
    }
    //결과 출력
    for i in 0..<num{
        for j in 0..<num{
            print(result[i][j], terminator: " ")
        }
        print("\n")
    }
}

floydSPT()

