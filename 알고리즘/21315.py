import sys
import math
from collections import deque
import copy
input = sys.stdin.readline

# 1 ~ N까지, 초기 상태에는 1이 맨위에 있음 번호 순서대로

n = int(input())
cards = deque([i + 1 for i in range(n)])


# 1번 단계:
def first(k):
    for i in range(2 ** k):
        cards.appendleft(cards.pop())

def step(i, k, start, end):
    if end == 0:
        print(cards)
        return
    origin = cards[end:]
    new_card = copy.deepcopy(cards[start: end])
    for _ in range(2 ** (k-i+1)):
        new_card.appendleft(new_card.pop())
    cards = copy.deepcopy(new_card + origin)
    step(i+1, k, 0, start+2 ** (k-i+1))


for k in range(math.sqrt(n)):
    

