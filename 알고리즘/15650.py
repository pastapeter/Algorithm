import sys

input = sys.stdin.readline


def solution():
    n, m = map(int, input().split())
    nums = [i + 1 for i in range(n)]
    dfs(nums, m, [], 0)


def dfs(numbers, m, answer, depth):
    if depth == len(numbers):
        if len(answer) == m:
            for i in range(m):
                print(answer[i], end=" ")
            print()
        return

    dfs(numbers, m, answer + [numbers[depth]], depth + 1)
    dfs(numbers, m, answer, depth + 1)


solution()
