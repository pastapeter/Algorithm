import sys
from collections import deque
import copy

input = sys.stdin.readline

dx = [-1, 1, 0, 0]
dy = [0, 0, 1, -1]

r, c, k = map(int, input().split())
board = []
visited = [[0] * c for _ in range(r)]
answer = 0
# 출발점 (0, r-1), 도착점 (c-1, 0)
for y in range(r):
    temp = list(map(str, input().rstrip()))
    board.append([0 if i == "." else 1 for i in temp])


def dfs(start, cnt):
    global answer
    if cnt == k:
        if start == (c - 1, 0):
            answer += 1
    else:
        for i in range(4):
            nx = start[0] + dx[i]
            ny = start[1] + dy[i]

            if nx < 0 or nx >= c or ny < 0 or ny >= r:
                continue
            if board[ny][nx] == 0 and visited[ny][nx] == 0:
                visited[ny][nx] = 1
                dfs((nx, ny), cnt + 1)
                visited[ny][nx] = 0


visited[r - 1][0] = 1
dfs((0, r - 1), 1)
print(answer)
