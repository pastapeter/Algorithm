import sys
from collections import deque

input = sys.stdin.readline

dx = [-1, 1, 0, 0, 0, 0]
dy = [0, 0, 1, -1, 0, 0]
dz = [0, 0, 0, 0, 1, -1]

m, n, h = map(int, input().split())
graph = []
for i in range(h):
    temp = []
    for y in range(n):
        temp.append(list(map(int, input().split())))
    graph.append(temp)

# 1은 익은토마토, 0은 익지 않은 토마토, -1은 토마토가 없음
starts = []
unmatured = set()
for z in range(h):
    for y in range(n):
        for x in range(m):
            if graph[z][y][x] == 1:
                starts.append((x, y, z))
            elif graph[z][y][x] == 0:
                unmatured.add((x, y, z))


def check(x, y, z):
    return x >= 0 and x < m and y >= 0 and y < n and z >= 0 and z < h


def bfs(starts):
    queue = deque()
    for start in starts:
        queue.append((start[0], start[1], start[2], 0))

    while queue:
        poped = queue.popleft()
        x, y, z = poped[0], poped[1], poped[2]
        day = poped[3]

        for i in range(6):
            nx = x + dx[i]
            ny = y + dy[i]
            nz = z + dz[i]

            if check(nx, ny, nz) and graph[nz][ny][nx] == 0:
                graph[nz][ny][nx] = graph[z][y][x] + 1
                unmatured.remove((nx, ny, nz))
                if len(unmatured) == 0:
                    return
                queue.append((nx, ny, nz, day + 1))


def solution():
    if len(unmatured) == 0:
        print(0)
        return
    bfs(starts)
    max_int = 0
    for z in range(h):
        for y in range(n):
            for x in range(m):
                max_int = max(max_int, graph[z][y][x])
                if graph[z][y][x] == 0:
                    print(-1)
                    return

    print(max_int - 1)


solution()
