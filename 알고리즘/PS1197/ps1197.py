from sys import maxsize
import sys
import heapq


input = sys.stdin.readline

v, e = map(int, input().split())
visited = [False]*(v+1)
graph = [[] for _ in range(v+1)]
heap = [(0, 1)]
cnt = 0
answer = 0
# c는 음수일 수 있음

for i in range(e):
    a, b, c = map(int, input().split())
    graph[a].append((c, b))
    graph[b].append((c, a))

while heap:
    if cnt == v:
        break
    weight, node = heapq.heappop(heap)
    if not visited[node]:
        visited[node] = True
        answer += weight
        cnt += 1 
        for i in graph[node]:
            heapq.heappush(heap, i)

print(answer)

