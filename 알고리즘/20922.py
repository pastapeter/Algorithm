import sys

input = sys.stdin.readline

# 같은 원소가 k개 이하로 들어있는 최장 연속 수열 길이
n, k = map(int, input().split())
nums = list(map(int, input().split()))
start = 0
end = -1
visited = [0] * 100001
answer = 0
while end < n:
    end += 1
    if end < n:
        visited[nums[end]] += 1
        while visited[nums[end]] > k and start <= end:
            visited[nums[start]] -= 1
            start += 1
        answer = max(answer, end - start + 1)

print(answer)
