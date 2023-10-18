import sys

input = sys.stdin.readline
from collections import deque

# 국경선 공유 나라 인구차이가 L 이상 R 이하
# 국경선이 모두 열리면 인구 인동 시작
# 인접한 칸만을 이용해 이동할 수 있으면, 오늘 하루 동안 연합
# 연합의 인구수 / 연합을 이루는 칸의 개수
# 연합 해제, 국경선 닫기

n, l, r = map(int, input().split())
graph = []

for y in range(n):
    graph.append(list(map(int, input().split())))


def check(x, y):
    return x >= 0 and x < n and y >= 0 and y < n


def isAlly(x1, y1, x2, y2):
    temp = abs(graph[y1][x1] - graph[y2][x2])
    return temp >= l and temp <= r


def bfs(start, visited):
    res = [start]
    dx = [-1, 1, 0, 0]
    dy = [0, 0, 1, -1]

    queue = deque()
    queue.append(start)

    visited[start[1]][start[0]] = 1
    total = 0
    while queue:
        now = queue.popleft()
        total += graph[now[1]][now[0]]
        for i in range(4):
            nx = now[0] + dx[i]
            ny = now[1] + dy[i]

            if not check(nx, ny):
                continue

            if visited[ny][nx] == 0 and isAlly(now[0], now[1], nx, ny):
                res.append([nx, ny])
                queue.append([nx, ny])
                visited[ny][nx] = 1

    return (res, total)
    # for y in range(n):
    #     for x in range(n):
    #         graph[y][x] = total // len(res)


def solution():
    cnt = 0
    answer = 0
    prev_answer = 0
    while True:
        res = []
        visited = [[0] * n for _ in range(n)]
        for y in range(n):
            for x in range(n):
                if visited[y][x] == 0:
                    res, total = bfs([x, y], visited)
                    if len(res) > 1:
                        answer += 1
                        for co in res:
                            graph[co[1]][co[0]] = total // len(res)

        if answer == prev_answer:
            return cnt
        else:
            cnt += 1
            prev_answer = answer


print(solution())
