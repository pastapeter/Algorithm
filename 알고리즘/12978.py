import sys

input = sys.stdin.readline
sys.setrecursionlimit(10000)

# 도시는 양방향 도로
# N-1개의 도로를 이용해 모든 도시들 사이에는 단 한개의 경로만
# 경찰서는 인접한 곳은 감시 가능
# 트리디피 문제라고함..
# 트리디피가 뭐임..?
# 트리디피는 N개의 정점이 있는데, N-1개의 간선이 있다고 했을때 트리디피일 가능성이
# 높다고 한다.
# 아 그르네 생각해보니깐 트리구조네

# 경우의수
# 1. x정점에 경찰서를 설치하는 경우
# 1-1. 자식 노드에는 경찰서를 설치하지않아도댐
# 1-2. 자식노드에는 경찰서를 설치해도댐

# 2. x 정점에 경찰서를 설치하지 않는 경우
# 2-1. 자식노드에는 경찰서가 설치되어야함

# 경우의 수가 그래서 2가지에서 뻗어나오는 것임
# 그래서
#
n = int(input())
graph = [[] for _ in range(n + 1)]
visited = [False] * (n + 1)
dp = [[0] * (n + 1) for _ in range(2)]
yes = 1
no = 0
for i in range(n - 1):
    u, v = map(int, input().split())
    graph[u].append(v)
    graph[v].append(u)


def dfs(depth):
    global answer
    visited[depth] = True
    dp[yes][depth] = 1  # 첫 정점에는 트리가 있다는 거임
    for child in graph[depth]:
        if visited[child]:
            continue
        dfs(child)
        # 현 정점에 경찰서를놓으려면, 자식 노드에 경찰서가 있거나 없거나 둘다 되는데
        # 더 적은 것을 놓아야 하는 것이다.
        dp[yes][depth] += min(dp[yes][child], dp[no][child])
        # 현 정점에 경찰서를 놓지 않으려면, 자식노드에 무조건 경찰서가 있어야한다.
        dp[no][depth] += dp[yes][child]


dfs(1)
print(min(dp[yes][1], dp[no][1]))
