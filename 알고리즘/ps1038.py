import sys
from collections import deque

input = sys.stdin.readline

T = int(input())
K, M, P = map(int, input().split())
graph = [[] for _ in range(M+1)]
indegree = [0]*(M+1)
indegree[0] = sys.maxsize

for _ in range(P):
    a, b = map(int, input().split())
    graph[a].append(b)
    indegree[b] += 1

q = deque()
qlist = {}
for node in range(1, M+1):
    if indegree[node] == 0:
        q.append(node)
        qlist[node] = []

while q:
    now = q.popleft()
    for node in graph[now]:
        indegree[node] -= 1
        if indegree[node] == 0:
            q.append(node)
            qlist[now] = qlist.get(now, []) + [node]

print(qlist)