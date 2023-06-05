import sys
from collections import deque

input = sys.stdin.readline
dx = [-1, 1, 0, 0]
dy = [0, 0, 1, -1]

T = int(input())
visited = []
board = []

# 문제 분석
# 그냥 개간단한 BFS임
# 너무 무난한 문제 유형


def bfs(start):
    q = deque()
    q.append(start)
    visited[start[1]][start[0]] = True

    while q:
        poped = q.popleft()

        for i in range(4):
            nx = poped[0] + dx[i]
            ny = poped[1] + dy[i]

            if nx < 0 or nx >= m or ny < 0 or ny >= n:
                continue
            if board[ny][nx] == 1 and not visited[ny][nx]:
                visited[ny][nx] = True
                q.append((nx, ny))


for _ in range(T):
    m, n, k = map(int, input().split())
    board = [[0] * m for _ in range(n)]
    visited = [[False] * m for _ in range(n)]
    candidates = []
    for _ in range(k):
        x, y = map(int, input().split())
        board[y][x] = 1
        candidates.append((x, y))
    answer = 0
    for candidate in candidates:
        if not visited[candidate[1]][candidate[0]]:
            answer += 1
            bfs(candidate)
    print(answer)
