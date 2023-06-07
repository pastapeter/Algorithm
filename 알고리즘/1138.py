import sys

input = sys.stdin.readline
n = int(input())
numberOfPeople = list(map(int, input().split()))
line = [0] * (n)
answer = ""

# 현재 내가 넘어가야하는 자리를 numberOfPeople에 정의되어있는것
# 만약에 0이라면, 넘어가야하는 자리는 없는 거임
# 0이 아니라면 몇개넘어가야하는지 적혀있는거임
# line[j]가 0이라면 비어있는 자리인데, left가 0보다 크다면 넘어가야하는것임
# 내 앞에 나보다 큰 사람 최소 1명이 들어가야하는 자리는 마련해둬야함
# 근데 line[j] != 0(자리가생긴것) 이라면 어차피 차례대로 들어가기 떄문에 신경쓰지않아도 댐
# line[j] == 0 이면서 left == 0이라면
# j자리까지 오면서 나보다 큰 사람이 들어갈자리를 다 마련하고 온거임

for i in range(n):
    left = numberOfPeople[i]
    for j in range(n):
        if left == 0 and line[j] == 0:
            line[j] = i + 1
            break
        elif line[j] == 0:
            left -= 1

for l in line:
    answer += f"{l} "
print(answer)
