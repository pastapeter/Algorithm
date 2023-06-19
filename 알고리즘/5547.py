import sys
from collections import deque

input = sys.stdin.readline

# (x,y)에서 오른쪽은 (x+1, y)
# (x, y)에서 y가 홀수일때, 아래쪽에 있는 정육각형 좌표는 (x, y+1)
# y가 짝수면 오른쪽아래의 정육면체 최ㅏ표는 (x, y+1)
# 핵심은 dfs던, bfs던 검정을 세는게 아니라 하얀을 세야한다.
# 원래 안쪽에도 bfs를 해줘서 빼줬는데, 히든이 자꾸 틀렸다
# 답지를 봤는데 하얀을 찾아서 검정 인접을 계산해주면 검정 안쪽을 굳이 검사하지 않아도된다.


dx = [-1, 1, 1, 0, 0, 1]
dy = [0, 0, 1, 1, -1, -1]

dx_2 = [-1, 1, 0, -1, -1, 0]
dy_2 = [0, 0, 1, 1, -1, -1]

w, h = map(int, input().split())
graph = [[0] * (w + 2) for _ in range(h + 2)]
for i in range(1, h + 1):
    graph[i][1 : w + 1] = map(int, input().split())

visited = [[0] * (w + 2) for i in range(h + 2)]


def check(x, y):
    return x >= 0 and x <= w + 1 and y >= 0 and y <= h + 1


def bfs(start):
    queue = deque()
    queue.append(start)
    visited[start[1]][start[0]] = 1
    building = []
    cnt = 0
    while queue:
        poped = queue.popleft()
        x = poped[0]
        y = poped[1]
        building.append(poped)
        for i in range(6):
            if y % 2 == 1:
                nx = x + dx[i]
                ny = y + dy[i]
            else:
                nx = x + dx_2[i]
                ny = y + dy_2[i]
            if not check(nx, ny):
                continue
            if graph[ny][nx] == 1:
                cnt += 1
                continue
            if visited[ny][nx] == 0:
                visited[ny][nx] = 1
                queue.append((nx, ny))
    return cnt


answer = 0
answer += bfs((0, 0))
print(answer)

# import sys
# from collections import defaultdict

# input = sys.stdin.readline
# sys.setrecursionlimit(10**6)

# w, h = map(int, input().split())
# inpHome = defaultdict(list)
# for i in range(h):
#     inpHome[i].extend(list(map(int, input().split())))
# home = [[0] * (w + 2) for _ in range(h + 2)]
# for y in range(h):
#     for x in range(w):
#         home[y + 1][x + 1] = inpHome[y][x]

# ans = 0
# visited = [[False] * (w + 2) for _ in range(h + 2)]


# def dfs(x, y):
#     global ans
#     if x < 0 or y < 0 or x > w + 1 or y > h + 1:
#         return
#     if home[y][x] == 1:
#         ans += 1
#     elif home[y][x] == 0 and visited[y][x] == False:
#         visited[y][x] = True
#         if y % 2 == 1:
#             dfs(x - 1, y)
#             dfs(x + 1, y)
#             dfs(x, y - 1)
#             dfs(x + 1, y - 1)
#             dfs(x, y + 1)
#             dfs(x + 1, y + 1)
#         else:
#             dfs(x - 1, y)
#             dfs(x + 1, y)
#             dfs(x - 1, y - 1)
#             dfs(x, y - 1)
#             dfs(x - 1, y + 1)
#             dfs(x, y + 1)


# dfs(0, 0)
# print(ans)
