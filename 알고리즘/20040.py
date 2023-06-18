# n 중에 3개가 일직선 X
# 2점 선택
# 교차가능
from collections import deque
import sys

input = sys.stdin.readline

n, m = map(int, input().split())
nums = [i for i in range(n)]

# 사이클을 찾는 방법은 2가지가 있다
# 1. dfs를 썻을때 back Edge가 있을때
# 2. Union_find 를 하는 도중, 2개의 부모가 같을때이다.


def get_parent(a):
    while a != nums[a]:
        a = nums[a]
    return a


def union(a, b):
    parentA = get_parent(a)
    parentB = get_parent(b)

    if parentA < parentB:
        nums[parentB] = parentA
    else:
        nums[parentA] = parentB


def solution():
    answer = 0
    for i in range(1, m + 1):
        a, b = map(int, input().split())
        if get_parent(a) == get_parent(b):
            answer = i
            break
        union(a, b)

    print(answer)


solution()
