import Foundation

let nmk = readLine()!.split(separator: " ").map { Int(String($0))! }
let (n,m,k) = (nmk[0], nmk[1], nmk[2])
typealias fireball = (m: Int, s: Int, d: Int)
var map = [[Int]: [fireball]]()
var result = 0

// dir: 위쪽부터 시계방향
let dx = [-1, -1, 0, 1, 1, 1, 0, -1]
let dy = [0, 1, 1, 1, 0, -1, -1, -1]
let dir = [[0, 2, 4, 6], [1, 3, 5, 7]]
for _ in 0..<m {
    let fireball = readLine()!.split(separator: " ").map { Int(String($0))! }
    map[[fireball[0]-1, fireball[1]-1]] = [(fireball[2], fireball[3], fireball[4])]
}

// k번 이동
for _ in 0..<k {
    // 각 칸(m)에 있는 파이어볼들에 대해 이동
    for mm in map {
        for fireball in mm.value {
          let index = map[[mm.key[0], mm.key[1]]]!.firstIndex(where: {$0 == fireball} )!
          map[[mm.key[0], mm.key[1]]]!.remove(at: index)
            let x = (n + (mm.key[0] + dx[fireball.d] * fireball.s) % n) % n
            let y = (n + (mm.key[1] + dy[fireball.d] * fireball.s) % n) % n
            map[[x, y]] = map[[x, y]] != nil ? map[[x, y]]! + [fireball] : [fireball]
        }
    }
    // 이동 종료 후 칸에 여러 개의 파이어볼이 존재하면 4개로 나누기
    for mm in map {
        if mm.value.count <= 1 { continue }
        var m = 0, s = 0
        var dList = Set<Bool>()
        for fireball in mm.value {
            m += fireball.m
            s += fireball.s
            dList.insert(((fireball.d % 2) == 0))
        }
        m /= 5
        s /= mm.value.count
        let d = 	dList.count == 1 ? 0 : 1
        map[[mm.key[0], mm.key[1]]] = m == 0
        ? nil : [(m, s, dir[d][0]),
                 (m, s, dir[d][1]),
                 (m, s, dir[d][2]),
                 (m, s, dir[d][3])]
    }
}

for mm in map {
    for fireball in mm.value {
        result += fireball.m
    }
}

print(result)
