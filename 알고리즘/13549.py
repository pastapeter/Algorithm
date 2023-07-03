import sys
from queue import PriorityQueue
import heapq

sys.setrecursionlimit(10**6)
input = sys.stdin.readline

n, k = map(int, input().split())


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

    graph2 = [[] for _ in range(200001)]
    for i in range(0, 100001):
        graph2[i].append((i + 1, 1))
        graph2[i].append((i - 1, 1))
        graph2[i].append((2 * i, 0))
    dist = [1e9] * 200001
    dist[n] = 0
    q = []
    heapq.heappush(q, (0, n))
    # heapq에 넣어줘
    # heapq는 앞에꺼를 기반으로 minheap임
    # 그래서 0, n으로 추가
    # q가 없을때까지
    while q:
        # pop을 했을때
        d, now = heapq.heappop(q)
        # 만약 d가 현재 dist[now] 보다 크다면, 갱신 필요없음
        if d > dist[now]:
            continue
        # 현재 위치까지 가는 최단거리가 줄어들었다면
        # 현재 위치에서 다른 곳으로 가는 곳도 갱신해줘야함
        for i in graph2[now]:
            # 현재 위치까지 가는 최단거리 + 다음위치까지가는 거리
            cost = dist + i[1]
            # 현재 위치까지 가는 최단거리 + 다음위치까지가는 거리 < 다음위치까지 가는 최단거리(지금까지나온것중)
            if cost < dist[i[0]]:
                dist[i[0]] = cost
                heapq.heappush(q, (cost, i[0]))

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
