import sys

input = sys.stdin.readline

# 수열 S에서 K개 원소를 삭제했을때, 모두 짝수
# 이말은 부분수열 중에서 K개 홀수까지 존재해도 괜찮다는 의미

n, k = map(int, input().split())
s = list(map(int, input().split()))

start = 0
end = 0
cnt = 0
answer = 0
while start <= end and end < n:
    if end >= n:
        break
    if s[end] % 2 != 0:
        cnt += 1
    while cnt > k:
        if s[start] % 2 != 0:
            cnt -= 1
        start += 1
    answer = max(answer, end - start + 1 - cnt)
    end += 1

print(answer)
