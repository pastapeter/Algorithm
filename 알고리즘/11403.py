import sys

input = sys.stdin.readline

n = int(input())
graph = []
for i in range(n):
    graph.append(list(map(int, input().split())))
for y in range(n):
    for x in range(n):
        if graph[y][x] == 0:
            graph[y][x] = 1e9

# answer = [[1e9] * n for _ in range(n)]

for k in range(n):
    for y in range(n):
        for x in range(n):
            graph[y][x] = min(graph[y][x], graph[y][k] + graph[k][x])


for y in range(n):
    for x in range(n):
        if graph[y][x] >= 1e9:
            graph[y][x] = 0
        else:
            graph[y][x] = 1

for y in range(n):
    print(*graph[y])
