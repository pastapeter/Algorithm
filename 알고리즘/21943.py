import sys
from itertools import permutations, combinations
from collections import deque
import copy

input = sys.stdin.readline

# N개의 양의 정수 Xi
# 곱, 더하기 연산자 N-1개
# 괄호는 무수히 많이 써도댐
answer = 0
res = []
result = 0


# 곱셈으로 구역을 나누고, 그 사이에 숫자를 넣으면 된다.
def dfs(cur, cnt, pick_list):
    print(pick_list)
    global result
    if cnt == 0:
        result = max(result, cur * sum(pick_list))
        return
    else:
        idx_list = range(len(pick_list))
        for pick_cnt in range(1, len(pick_list) - cnt + 1):
            for comb in combinations(idx_list, pick_cnt):
                copy_pick_list = pick_list[:]
                comb = list(reversed(comb))
                temp_sum = 0
                for idx in comb:
                    temp_sum += copy_pick_list.pop(idx)
                dfs(cur * temp_sum, cnt - 1, copy_pick_list)


def solution():
    global answer, res
    n = int(input())
    numbers = list(map(int, input().split()))
    p, q = map(int, input().split())
    dfs(1, q, numbers)
    return result


print(solution())
