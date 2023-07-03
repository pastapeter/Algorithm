import sys
from queue import PriorityQueue

sys.setrecursionlimit(10**6)
input = sys.stdin.readline

n, k = map(int, input().split())
dist = [1e9 for i in range(100001)]
dist[n] = 0

if k <= n:
    print(n - k)
else:
    graph = [[] for _ in range(k + 2)]
    for i in range(0, k + 2):
        if i > 0:
            graph[i].append([1, i - 1])
        if i < k + 1:
            graph[i].append([1, i + 1])
        if 2 * i <= k + 1:
            graph[i].append([0, 2 * i])

    def dijkstra(start, end):
        d = [1e9] * (end + 2)
        d[start] = 0
        pq = PriorityQueue()
        pq.put((0, start))
        while pq.qsize() > 0:
            temp = pq.get()
            k = temp[0]
            u = temp[1]
            if k > d[u]:
                continue
            for w, v in graph[u]:
                if d[v] > d[u] + w:
                    d[v] = d[u] + w
                    pq.put((d[v], v))
        return d[end]

    print(dijkstra(n, k))
