import sys
from collections import deque

input = sys.stdin.readline
N, M, K = map(int, input().split())
colmap = [[1]*(M+1) for _ in range(N+1)]
trashes = []
answer = 0
temp = 0

for i in range(K):
    y, x = map(int, input().split())
    trashes.append((x, y))
    colmap[y][x] = 0

def dfs(start):
    dx = [-1, 1, 0, 0]
    dy = [0, 0, 1, -1]
    q = deque([start])

    while len(q):
        poped = q.popleft()
        for i in range(4):

            nx = poped[0] + dx[i]
            ny = poped[1] + dy[i]

            if nx < 1 or ny < 1 or nx >= M+1 or ny >= N+1:
                continue

            if colmap[ny][nx] == 0:
                q.append((nx, ny))
                temp += 1
                colmap[ny][nx] = 1
        

for trash in trashes:
    if colmap[trash[1]][trash[0]] == 0:
        global temp
        temp = 0
        dfs(trash)
        answer = max(temp, answer)

print(answer)