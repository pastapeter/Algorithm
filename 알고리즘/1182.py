import sys

input = sys.stdin.readline

# n개의 정수로 이뤄진 수열이 있을떄, 크기가 양수인 부분 수열 중
# 수열의 원소를 다 더한 것이 S

n, s = map(int, input().split())
nums = list(map(int, input().split()))
answer = 0


def dfs(start, depth, cnt):
    global answer, s, n
    if start == s and cnt > 0:
        answer += 1

    for i in range(depth, n):
        dfs(start + nums[i], i + 1, cnt + 1)


dfs(0, 0, 0)
print(answer)
