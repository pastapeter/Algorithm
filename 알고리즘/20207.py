import sys
from functools import cmp_to_key

input = sys.stdin.readline
# 연속된 두 일자에 일정에 1개 이상 있다면 연속
# 연속된 일정은 하나의 직사각형
#

# 시작날짜와 종료날짜 포함
# 1. 시작일 이 앞선 일정부터
# 2. 같을 경우 긴 것부터
# 3. 일정은 가능한 최 상단에 배치
# 4. 일정 하나의 세로의 길이는 1이다.
# 5. 하루의 폭은 1이다.

n = int(input())
# 처음에 틀렸던 이유는 1 ~ 365일이 모두 차있을때,
# 내 로직으로는 각 일자의 일정 개수를 세어주고
# 전날의 일정이 있고, 다음날의 일정이 모두 없을떄,
# 그 때 색종이를 붙여주면 되는 것이었다
# 근데, 1 ~ 365가 다 차있을 때는 366이 없어서 조건성립을 할 수 없었기에
# 그래프 가로를 367까지 늘려줬다.
graph = [[0] * 367 for _ in range(n)]
schedules = []
for i in range(n):
    a, b = map(int, input().split())
    schedules.append((a, b))


def compare(a, b):
    if a[0] == b[0]:
        if a[1] - a[0] < b[1] - b[0]:
            return 1
        else:
            return -1
    elif a[0] > b[0]:
        return 1
    else:
        return -1


schedules.sort(key=cmp_to_key(compare))

for s in schedules:
    for i in range(n):
        if (
            len(set(graph[i][s[0] : s[1] + 1])) == 1
            and list(set(graph[i][s[0] : s[1] + 1]))[0] == 0
        ):
            for j in range(s[0], s[1] + 1):
                graph[i][j] = 1
            break

flag = False
start = 0
end = 0
line = set()
answer = 0
for x in range(1, 367):
    cnt = 0
    for y in range(n):
        if graph[y][x] == 1:
            cnt += 1
            line.add(y)
    if cnt > 0 and flag == False:
        # 첫 시작
        start = x
        flag = True
    if cnt == 0 and flag == True:
        # 끝
        end = x - 1
        answer += len(line) * (end - start + 1)
        line.clear()
        flag = False

print(answer)
