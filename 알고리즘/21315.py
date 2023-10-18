import sys
import math

input = sys.stdin.readline

N = int(input())
target = list(map(int, input().split()))
# 1 ~ N 초기 상태
cards = [i for i in range(1, N + 1)]
answer = 0


# 1단계 -> 카드 더미 중 밑에서 25^K 카드를 더미 맨 위로
def first(cards, k):
    return cards[-(2**k) :] + cards[: len(cards) - 2**k]


# i단계는 직전에 맨 위로 올린카드 중 밑에서 2 ** (K-i+1) 개의
# 카드를 더미의 맨 위로 올린다.
def dfs(cards, depth, k):
    global answer, target
    if cards == target:
        return cards

    if depth == 1:
        cards = dfs(first(cards, k), depth + 1, k)
    else:
        if k - depth + 1 >= 0:
            new_cards = (
                cards[2 ** (k - depth + 1) : 2 ** (k - depth + 2)]
                + cards[: 2 ** (k - depth + 1)]
                + cards[2 ** (k - depth + 2) :]
            )
            cards = dfs(new_cards, depth + 1, k)
    return cards


def solution():
    global cards, N, target
    res = []
    for k in range(1, int(math.sqrt(N)) + 1):
        temp = dfs(cards, 1, k)
        res.append((temp, k))

    res2 = []
    for r, old_k in res:
        for k in range(1, int(math.sqrt(N)) + 1):
            temp = dfs(r, 1, k)
            if temp == target:
                print(old_k, k)
                return


solution()
