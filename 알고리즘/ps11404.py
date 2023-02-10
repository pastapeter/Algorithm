import sys
import heapq

input = sys.stdin.readline
INF = int(1e9)

n = int(input())
m = int(input())
graph = [[INF]*(n+1) for _ in range(n+1)]

for y in range(1, n+1):
    graph[y][y] = 0

for i in range(m):
    a, b, c = map(int, input().split())
    graph[a][b] = min(graph[a][b], c)
    
for k in range(1, n+1):
    for a in range(1, n+1):
        for b in range(1, n+1):
            graph[a][b] = min(graph[a][b], graph[a][k]+graph[k][b])

for y in range(1, n+1):
    for x in range(1, n+1):
        if graph[y][x] == INF:
            print(0, end=' ')
        else:
            print(graph[y][x], end=' ')
    print()
        
