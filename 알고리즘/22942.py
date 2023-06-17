import sys
from itertools import combinations

input = sys.stdin.readline

# N개의 원 중 임의의 두 원을 선택했을 때, 교점을 지나지 않아야한다.
# 하나의 원이 다른 원에 존재하거나 외부에 존재
# 원과 x축이 만나는 좌표를 { } 로 생각하고 stack을 기반해서 풀면된다.
# 자료구조문제는 어려우면 생각해내기 어렵고, 모르고 접근하면 더 어려운듯..


def solution():
    n = int(input())
    circles = []
    for i in range(n):
        x, r = map(int, input().split())
        circles.append((x - r, i, "l"))
        circles.append((x + r, i, "r"))
    circles.sort()
    stack = []
    for point in circles:
        if len(stack) == 0:
            stack.append(point)
        else:
            if stack[-1][1] != point[1]:
                # 다른 원이라면
                if stack[-1][1] == point[0] or stack[-1][2] != point[2]:
                    # stack.top이 다른 원일 경우, 둘의 x축과 접하는 좌표가 같은 경우는 일단 교점 생김
                    # 그러거나 다른데, 한쪽은 열리는 구간, 한쪽은 닫히는 구간이면, 하나의 원이 닫히기 전에
                    # 다른 원이 닫힌것이니깐 교점이 2개 생길 수 밖에없다.
                    print("NO")
                    return
                else:
                    stack.append(point)
            else:
                stack.pop()

    print("YES")


solution()
