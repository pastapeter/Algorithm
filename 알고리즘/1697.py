import sys
import copy

sys.setrecursionlimit(10**9)
from collections import deque

input = sys.stdin.readline

# n 100000, k 100000
# x-1, x+1, 2*x

n, k = map(int, input().split())
d = [-1, 1, 2]

# 여기서 dfs보다 bfs를 사용해야하는 이유
# dfs는 -1, +1, *2 를 할때마다 무조건 3개씩 가지치기를 해야하는 상황이 온다.
# 하지만 bfs는 확산형태이기 때문에, 가장 먼저 찾는 친구가 가장 빠른 것이다.
# 결국은 bfs, dfs를 둘다 고민해보고 더 나은결정을 하는 것이 중요하다.


def bfs():
    q = deque()
    q.append([n, 0])
    visited = set()
    visited.add(n)
    res = 1e9
    while q:
        current, cnt = q.popleft()
        if current == k:
            return cnt
        for i in range(3):
            if i == 2:
                nx = current * d[i]
            else:
                nx = current + d[i]

            if nx >= 0 and nx < 1000001:
                if nx not in visited:
                    q.append([nx, cnt + 1])
                    visited.add(nx)

    return res


answer = 1e9
visited = [0 for i in range(100001)]


def check(x):
    return x >= 0 and x < 100001


def dfs(start, cnt):
    global answer, visited
    visited[start] = 1
    if start == k:
        answer = min(answer, cnt)
        return

    for i in range(3):
        if i == 0:
            new_s = start + 1
            if check(new_s) and visited[new_s] != 1:
                visited[new_s] = 1
                dfs(new_s, cnt + 1)
                visited[new_s] = 0
        elif i == 1:
            new_s = start - 1
            if check(new_s) and visited[new_s] != 1:
                visited[new_s] = 1
                dfs(new_s, cnt + 1)
                visited[new_s] = 0
        else:
            new_s = start * 2
            if check(new_s) and visited[new_s] != 1:
                visited[new_s] = 1
                dfs(new_s, cnt + 1)
                visited[new_s] = 0


dfs(n, 0)
print(answer)

# print(bfs())
