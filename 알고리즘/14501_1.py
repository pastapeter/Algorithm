import sys

input = sys.stdin.readline

# N번 가능함
n = int(input())
s = []
for i in range(n):
    a, b = map(int, input().split())
    s.append((a, b))

answer = 0


def dfs(depth, money):
    global answer, s
    if depth > n - 1:
        answer = max(answer, money)
        return
    for i in range(depth, n):
        if i + s[i][0] <= n:
            dfs(i + s[i][0], money + s[i][1])
        else:
            dfs(i + s[i][0], money)


dfs(0, 0)
print(answer)
