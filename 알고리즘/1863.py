import sys

input = sys.stdin.readline
n = int(input())
points = []
for i in range(n):
    x, y = map(int, input().split())
    points.append((x, y))

stack = []
answer = 0
# Stack 사용시 항상 주의할점
# Stack에서 while로 뺄때 뺀 다음 어떠한 수가 남았는지를 생각하자
# Stack을 사용할때, 넣고 빼고의 순서가 중요하다.
# 아래에서는 자신보다 큰거를 다 뺏지만, 그 다음 수가 자신보다 같을때 그리고 for문이 끝나버린다면
# 1개가 더 많아진다.
# 그렇기 때문에 이런 문제류를 주의해야한다.
# 그래도 풀면서 빠르게 스택으로 접근할 수 있었음 -> 뭔가 눈이 생겼나?


for point in points:
    if len(stack) == 0:
        stack.append(point)
    else:
        while len(stack) > 0 and stack[-1][1] > point[1]:
            stack.pop()
            answer += 1
        if len(stack) > 0 and stack[-1][1] == point[1]:
            continue
        stack.append(point)

newstack = [i for i in stack if i[1] > 0]
answer += len(newstack)
print(answer)
