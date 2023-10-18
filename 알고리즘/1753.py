import sys
import heapq
from queue import PriorityQueue

input = sys.stdin.readline

V, E = map(int, input().split())
start = int(input())
graph = [[] * (V + 1) for _ in range(V + 1)]
for _ in range(E):
    u, v, w = map(int, input().split())
    graph[u].append((w, v))


def dijkstra(start):
    q = []
    dist = [1e9 for _ in range(V + 1)]
    dist[start] = 0
    heapq.heappush(q, (0, start))

    while q:
        d, cur = heapq.heappop(q)

        if dist[cur] < d:
            continue

        for adjacent in graph[cur]:
            cost = dist[cur] + adjacent[0]
            if cost < dist[adjacent[1]]:
                dist[adjacent[1]] = cost
                heapq.heappush(q, (cost, adjacent[1]))
    return dist[1:]


for i in dijkstra(start):
    if i == 1e9:
        print("INF")
    else:
        print(i)
