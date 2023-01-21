import sys

input = sys.stdin.readline

N = int(input())
arr = list(map(int, input().split()))
dp = [ [0] * N for _ in range(N)]
commands = []
results = []

for i in range(N):
    dp[i][i] = 1
for i in range(N-1):
    if arr[i] == arr[i+1]: dp[i][i+1] = 1
    else : dp[i][i+1] = 0
for count in range(N-2):
    for i in range(N-2-count):
        j = i+2+count
        if arr[i] == arr[j] and dp[i+1][j-1] == 1:
            dp[i][j] = 1

M = int(input())

for i in range(M):
    S, E = map(int, input().split())
    commands.append((S-1, E-1))
for command in commands:
    results.append(dp[command[0]][command[1]])
for result in results:
    print(result)