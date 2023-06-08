import sys

input = sys.stdin.readline

# k개의 랜선
# 길이가 다름
# N개의 같은 길이 랜선으로 만들고 싶음

k, n = map(int, input().split())
lines = []
for i in range(k):
    lines.append(int(input().rstrip()))
left = 1
# 처음에 틀렸던 이유는
# right값을 max(lines)로 잡지않은것이다
# n이사실 뭐가 나올지 모르고
# k의 첫번째가 작고, n이 2가 나왔더라면, 무조건 무한루프가 돌던 코드였음
right = max(lines)

while right >= left:
    mid = (left + right) // 2
    temp = 0
    for line in lines:
        temp += line // mid
    if temp >= n:
        left = mid + 1
    elif temp < n:
        right = mid - 1

print(right)
