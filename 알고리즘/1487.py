import sys
from functools import cmp_to_key

input = sys.stdin.readline

n = int(input())
people = []
for i in range(n):
    a, b = map(int, input().split())
    people.append((a, b))

people.sort(key=lambda x: (x[0], x[1]))
prices = []

# 그냥 전부 다해보면 되겠다는 생각을 했는데
# sort하고 처리할때, Greedy로 처리하면 되겠다고 생각했다.
# 각각 사람에게 배달하는 비용에 대해서 좀 다르게 생각해서 한참동안 헤멨던 문제이다


for i in range(n):
    total_price = 0
    for j in range(i, n):
        price = people[i][0] - people[j][1]  # 현재 가격에서 그사람의 배송비용을 뺴는 것을 좀 헷갈렸다.
        # 좀 더 잘 읽어봤어야하는 문제..
        # 10분컷문제였는데 20~30분이 걸렸다.
        if price > 0:
            total_price += price
    prices.append(total_price)
highest = max(prices)
if highest <= 0:
    print(0)
else:
    print(people[prices.index(highest)][0])
