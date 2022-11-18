import sys

input = sys.stdin.readline

N, M = map(int, input().split())
graph = [[] for _ in range(N+1)]
indegree = [0] * (N+1)
indegree[0] = sys.maxsize

for _ in range(M):
    a, b = map(int, input().split())
    graph[a].append(b)
    indegree[b] += 1

q = []
for node in range(N+1):
    if indegree[node] == 0:
        q.append(node)

while q:
    now = q.pop(0)
    print(now, end=" ")

    for node in graph[now]:
        indegree[node] -= 1
        if indegree[node] == 0:
            q.append(node)
print()