import sys
from itertools import combinations

input = sys.stdin.readline

n = int(input())
players = [i for i in range(n)]
s = []
for i in range(n):
    s.append(list(map(int, input().split())))
answer = 1e9
visited = [0 for _ in range(n)]


def dfs(depth):
    if depth == n:
        find_best_score()
        return
    visited[depth] = 1
    dfs(depth + 1)
    visited[depth] = 0
    dfs(depth + 1)


def find_best_score():
    global answer
    start_int = 0
    link_int = 0
    for i in range(n):
        for j in range(n):
            if visited[i] and visited[j]:
                start_int += s[i][j]
            elif not visited[i] and not visited[j]:
                link_int += s[i][j]

    diff = abs(start_int - link_int)
    answer = min(answer, diff)


dfs(0)
print(answer)
