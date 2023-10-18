import sys
from collections import defaultdict
from collections import deque

input = sys.stdin.readline


n = int(input())
graph = [[] for _ in range(n + 1)]
for _ in range(n - 1):
    parent, child = map(int, input().split())
    graph[parent].append(child)
    graph[child].append(parent)


def bfs():
    q = deque()
    q.append(1)
    visited = [0 for _ in range(n + 1)]
    visited[1] = 1
    tree = defaultdict(list)
    tree2 = defaultdict(list)
    while q:
        cur = q.popleft()

        for adjacent in graph[cur]:
            if visited[adjacent] == 0:
                tree[cur].append(adjacent)
                tree2[adjacent].append(cur)
                q.append(adjacent)
                visited[adjacent] = 1
    res = [0 for _ in range(n + 1)]
    for item in tree2.items():
        res[item[0]] = item[1]
    return res


ans = bfs()
for a in ans[2:]:
    print(a[0])
