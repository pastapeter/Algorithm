import sys
import copy

input = sys.stdin.readline
subset = set()
answer = 0


def make_subset(q, numbers, temp, depth):
    global subset
    if depth == len(numbers):
        subset.add(set(copy.deepcopy(temp)))
        return

    for i in range(q + 1):
        temp[i] += f"{numbers[depth]}"
        make_subset(q, numbers, temp, depth + 1)
        temp[i] = temp[i][:-1]


def solution():
    global answer, subset
    n = int(input())
    numbers = list(map(int, input().split()))
    p, q = map(int, input().split())
    make_subset(q, numbers, ["" for _ in range(q + 1)], 0)
    print(subset)
    return answer


solution()
