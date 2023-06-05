import sys

input = sys.stdin.readline
# 지구->달
dx = [-1, 0, 1]
dy = [1, 1, 1]
# 우주선은 두번연속 움직일 수 없음
# dp? 그리디?
n, m = map(int, input().split())
# graph = [[0]*m for _ in range(n)]
graph = []
for y in range(n):
    graph.append(list(map(int, input().split())))


def check(x, y):
    return x >= 0 and x < m and y >= 0 and y < n


answer = sys.maxsize
# 시간초, N, M 이 둘다 6^6승이 1억을 넘지않음


def dfs(start, dir, x, y):
    global answer
    if len(start) == n:
        answer = min(answer, sum(start))
        return
    for i in range(3):
        if i == dir:
            continue
        ny = y + dy[i]
        nx = x + dx[i]
        if check(nx, ny):
            dfs(start + [graph[ny][nx]], i, nx, ny)


for i in range(m):
    for dir in range(3):
        dfs([graph[0][i]], dir, i, 0)

print(answer)
