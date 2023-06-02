import sys

input = sys.stdin.readline
cols = []
N = int(input())
answer = 0
stack = []

for i in range(N):
    L, H = map(int, input().split())
    cols.append((L, H))

cols.sort(key=lambda x: x[0])

# stack을 활용한 넓이 계산
for col in cols:
    if len(stack) == 0:
        stack.append(col)
    else:
        if stack[0][1] < col[1]:  # 들어온 기둥이 더 큼
            poped = stack[0]
            stack.clear()
            answer += (col[0] - poped[0]) * poped[1]
            stack.append(col)
        else:
            stack.append(col)
# cols를 다돌면서 넓이 계산할 수 있는 것은 다 계산
# 넓이를 계산못하는것, stack에 맨앞보다 모두 다 작은 기둥이 들어왔을 경우
# 그때는 stack의 가장마지막 기둥보다 작은놈을 다 빼고 계싼
# 그래도 stack에 여러개가 남아있음
# 가장 높은 기둥이 동일한 높이로 남아있는경우임
# 다 빼고
# 1개 더해줌
# 예를들어서 6, 9에 있으면, 9-6을 하면서 3임, 근데 사실 넓이는 4임 그래서 1 더해줌
# 근데 애초에 1개가 있을 경우도 있으니깐 그럴 경우를 대비해야해서 44줄이 존재함
while len(stack) != 0:
    last = stack.pop()
    while len(stack) != 0 and stack[-1][1] <= last[1]:
        temp = stack.pop()
        if len(stack) == 0:
            answer += last[1] * (last[0] - temp[0])
    if len(stack) != 0:
        answer += (last[0] - stack[-1][0]) * last[1]
    else:
        answer += last[1]

print(answer)
