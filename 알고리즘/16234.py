import sys
from collections import deque

input = sys.stdin.readline

dx = [-1, 1, 0, 0]
dy = [0, 0, 1, -1]

# 두 나라 차이가 L 이상 R이하, 국경선 열기
# 국경선이 열렸다면 인구이동
# 국경선 bfs 연합찾기
# 각 카의 인구수는 연합의 인구수 / 연합을 이루는 칸의 개수

n, l, r = map(int, input().split())
graph = []
visited = [[0] * n for _ in range(n)]


def check(x, y):
    return x >= 0 and x < n and y >= 0 and y < n


for i in range(n):
    graph.append(list(map(int, input().split())))


def bfs(start):
    queue = deque()
    queue.append(start)
    visited[start[1]][start[0]] = 1
    group = []

    while queue:
        poped = queue.popleft()
        cur = graph[poped[1]][poped[0]]
        group.append(poped)

        for i in range(4):
            nx = poped[0] + dx[i]
            ny = poped[1] + dy[i]

            if not check(nx, ny):
                continue

            if abs(graph[ny][nx] - cur) >= l and abs(graph[ny][nx] - cur) <= r:
                if visited[ny][nx] == 0:
                    visited[ny][nx] = 1
                    queue.append((nx, ny))

    return group


answer = 0
while True:
    visited = [[0] * n for _ in range(n)]
    aliance = []
    for y in range(n):
        for x in range(n):
            if visited[y][x] == 0:
                aliance.append(bfs((x, y)))
    if len(aliance) == n * n:
        break

    for a in aliance:
        if len(a) == 1:
            continue
        temp = 0
        for cor in a:
            temp += graph[cor[1]][cor[0]]
        next = temp // len(a)
        for cor in a:
            graph[cor[1]][cor[0]] = next
    answer += 1

print(answer)
