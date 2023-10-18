"<<<<<" "5"
"<<<><" "3"

import sys
from collections import deque

p = input()


def make_graph(p):
    graph = [[] for _ in range(len(p) + 2)]
    for i in range(len(p)):
        if p[i] == "<":
            graph[i + 1].append(i)
        else:
            graph[i + 1].append(i + 2)
    return graph


def bfs(start, graph):
    n = len(graph)
    visited = [0 for i in range(n)]
    q = deque()
    q.append(start)
    visited[start] = 1
    while q:
        cur = q.popleft()
        if cur == 0 or cur == n - 1:
            return 1
        for adjacent in graph[cur]:
            if visited[adjacent] == 0:
                visited[adjacent] = 1
                q.append(adjacent)
    return 0


graph = make_graph(p)
answer = 0
for i in range(len(p)):
    answer += bfs(i + 1, graph)

print(answer)
