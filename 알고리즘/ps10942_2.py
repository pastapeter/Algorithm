import sys

input = sys.stdin.readline

N = int(input())
arr = list(map(int, input().split()))
arr.insert(0, 0)
dp = [ [0] * (N+1) for _ in range(N+1)]
results = []

for x in range(1, N+1):
    dp[1][x] = 1

for x in range(1, N):
    if arr[x+1] == arr[x]:
        dp[2][x+1] = 1

for y in range(3, N+1):
    for x in range(y, N+1):
        if arr[x-y+1] == arr[x] and dp[y-2][x-1] == 1:
            dp[y][x] = 1

M = int(input())

for i in range(M):
    S, E = map(int, input().split())
    results.append(dp[E-S+1][E])

for result in results:
    print(result)