import Foundation

struct Coordin: Hashable {
    var x: Int
    var y: Int
}

func isHorizontal(coor1: (x: Int, y:Int, time: Int), coor2: (x: Int, y: Int, time: Int)) -> Bool {
    if coor1.x == coor2.x {
        return false
    }
    return true
}

var visits: [Coordin:[Coordin]] = [:]
var queue: [[(x: Int, y: Int, time: Int)]] = []

func makeVisited(robot: [(x: Int, y: Int, time: Int)]) {
    
    let robotleg1 = robot[0]
    let robotleg2 = robot[1]
    
    let coor1 = Coordin(x: robotleg1.x, y: robotleg1.y)
    let coor2 = Coordin(x: robotleg2.x, y: robotleg2.y)
    
    // 일단 찾아보자
    var v1 = visits[coor1]!
    var v2 = visits[coor2]!
    
    // 없다면
    if !(v1.contains(coor2) || v2.contains(coor1)) {
        queue.append(robot)
        v1.append(coor2)
        v2.append(coor1)
        visits.updateValue(v1, forKey: coor1)
        visits.updateValue(v2, forKey: coor2)
    }
    
}

func bfs(robot: [(x: Int, y: Int, time: Int)], board: [[Int]]) -> Int {
    let n = board.count
    var visited : [[[Int]]] = []
    visited.append([[robot[0].x, robot[0].y], [robot[1].x, robot[1].y]])
    
    
    for y in board.indices {
        for x in board.indices {
            visits.updateValue([], forKey: Coordin(x: x, y: y))
        }
    }
    
    queue = [robot]
    
    let mx =  [1, 1, -1, -1]
    let my = [1, -1, -1, 1]
    
    let chx = [0, 0, 0, 0]
    let chy = [1, -1, -1, 1]
    
    let mvx =  [1, -1, 1, -1]
    let mvy = [1, 1, -1, -1]
    let cvx = [1, -1, 1, -1]
    let cvy = [0,0,0,0]
    
    let hx = [1, -1, 0, 0]
    let hy = [0, 0, 1, -1]
    
    let vx = [0, 0, 1, -1]
    let vy = [1, -1, 0, 0]
    
    while !queue.isEmpty {
        print(queue)
        var now = queue.removeFirst()
        now.sort {
            if $0.x < $1.x {
                return true
            } else if $0.x == $1.x {
                return $0.y < $1.y
            } else {
                return false
            }
        }
        
        if (now[0].x == n-1 && now[0].y == n - 1)  {
            return now[0].time
        }

        if (now[1].x == n-1 && now[1].y == n - 1) {
            return now[1].time
        }
        
        let ishoriziontal = isHorizontal(coor1: now[0], coor2: now[1])
        
        for i in 0..<4 {
            var newRobot: [(x: Int, y: Int, time: Int)] = []
            if ishoriziontal {
                newRobot = now.map { (x: $0.x + hx[i], y: $0.y + hy[i], time: $0.time + 1)}
            } else {
                newRobot = now.map { (x: $0.x + vx[i], y: $0.y + vy[i], time: $0.time + 1)}
            }
            
            // 앞에 파트
            if newRobot[0].x >= n || newRobot[0].y >= n || newRobot[0].x < 0 || newRobot[0].y < 0 {
                continue
            }
            
            // 뒤의 파트
            if newRobot[1].x >= n || newRobot[1].y >= n || newRobot[1].x < 0 || newRobot[1].y < 0 {
                continue
            }
            
            // 갈수 없는곳?
            if board[newRobot[0].y][newRobot[0].x] == 1 ||  board[newRobot[1].y][newRobot[1].x] == 1 {
                continue
            }
            
            makeVisited(robot: newRobot)
        
        }
        
        for i in 0..<4 {
            var temp = (x: 1, y: 1, time:0)
            var resultcoor = (x: 1, y: 1, time:0)
            var coor = (x: 1, y: 1, time:0)
            
            if ishoriziontal {
                
                if i == 0 || i == 1 {
                    temp = (x: now[0].x, y: now[0].y, time: now[0].time + 1)
                    resultcoor = (x: now[0].x + chx[i], y: now[0].y + chy[i], time: now[0].time + 1)
                    coor = (x: now[0].x + mx[i], y: now[0].y + my[i], time: now[0].time + 1)
                } else {
                    temp = (x: now[1].x, y: now[1].y, time: now[1].time + 1)
                    resultcoor = (x: now[1].x + chx[i], y: now[1].y + chy[i], time: now[1].time + 1)
                    coor = (x: now[1].x + mx[i], y: now[1].y + my[i], time: now[1].time + 1)
                }

            } else {
                if i == 0 || i == 1 {
                    temp = (x: now[0].x, y: now[0].y, time: now[0].time + 1)
                    resultcoor = (x: now[0].x + cvx[i], y: now[0].y + cvy[i], time: now[0].time + 1)
                    coor = (x: now[0].x + mvx[i], y: now[0].y + mvy[i], time: now[0].time + 1)
                } else {
                    temp = (x: now[1].x, y: now[1].y, time: now[1].time + 1)
                    resultcoor = (x: now[1].x + cvx[i], y: now[1].y + cvy[i], time: now[1].time + 1)
                    coor = (x: now[1].x + mvx[i], y: now[1].y + mvy[i], time: now[1].time + 1)
                }
            }
            
            if coor.x >= n || coor.y >= n || coor.x < 0 || coor.y < 0 {
                continue}
            
            if board[coor.y][coor.x] == 1 {
                continue
            }
            
            if board[resultcoor.y][resultcoor.x] == 1 {
                continue
            }
        
            
            makeVisited(robot: [temp, resultcoor])
//            if !(visited.contains([[temp.x,temp.y], [resultcoor.x, resultcoor.y]])
//                 || visited.contains([[resultcoor.x, resultcoor.y], [temp.x, temp.y]]))
//            {
//                queue.append([temp, resultcoor])
//                visited.append([[temp.x, temp.y], [resultcoor.x, resultcoor.y]])
//            }
            
            
        }
        
    }
    return 0
}

func solution(_ board:[[Int]]) -> Int {
    
    return bfs(robot: [(x: 0, y:0, time: 0), (x: 1, y: 0, time:0) ], board: board)
    
}

print(solution( [[0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 1, 1, 1, 1, 1, 0, 0], [0, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 1, 1, 1, 1, 1, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1, 0]]))
