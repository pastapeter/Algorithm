import sys
from itertools import permutations

input = sys.stdin.readline


def solution_with_itertools():
    n, m = map(int, input().split())
    nums = [i + 1 for i in range(n)]
    answer = permutations(nums, m)
    for ans in answer:
        for ele in ans:
            print(ele, end=" ")
        print()


def solution_without_itertools():
    n, m = map(int, input().split())
    nums = [i + 1 for i in range(n)]
    dfs(nums, m, [], 0)


def dfs(numbers, m, answer, depth):
    if len(answer) == m:
        for i in range(m):
            print(answer[i], end=" ")
        print()
        return

    for i in range(len(numbers)):
        if numbers[i] not in answer:
            dfs(numbers, m, answer + [numbers[i]], depth + 1)


solution_without_itertools()
