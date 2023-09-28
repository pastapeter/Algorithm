#  N*N
# 색이 다른 인접한 두칸 교환
# 모두 같은 색으로 이루어져 있는 가장 긴 연속 부분
# 사탕이 채워진 상태가 주어졌을때, 최대 갯수

n = int(input())
graph = []
for i in range(n):
    graph.append(list(map(str, input())))

# C, P, Z, Y
dx = [1, 0]
dy = [0, 1]


def check(x, y):
    return x >= 0 and x < n and y >= 0 and y < n


def same(x1, y1, x2, y2):
    return graph[y1][x1] == graph[y2][x2]


def count_max():
    res = 0
    for i in range(n):
        row = graph[i]
        res = max(res, twoPointer(row))
        col = list(zip(*graph))[i]
        res = max(res, twoPointer(col))
        if res == n:
            return res
    return res


def twoPointer(row):
    start = 0
    res = 0
    temp = row[0]
    for i in row:
        if i == temp:
            start += 1
        else:
            res = max(start, res)
            temp = i
            start = 1
    res = max(start, res)
    return res


answer = 0
visited = set()
for y in range(n):
    for x in range(n):
        now = graph[y][x]

        for i in range(2):
            nx = x + dx[i]
            ny = y + dy[i]

            if check(nx, ny) and not same(x, y, nx, ny):
                if (nx, ny, x, y) not in visited and (x, y, nx, ny) not in visited:
                    graph[ny][nx], graph[y][x] = graph[y][x], graph[ny][nx]
                    answer = max(answer, count_max())
                    visited.add((nx, ny, x, y))
                    visited.add((x, y, nx, ny))
                    graph[ny][nx], graph[y][x] = graph[y][x], graph[ny][nx]

print(answer)
