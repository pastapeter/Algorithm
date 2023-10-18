import sys
from itertools import combinations

input = sys.stdin.readline

d = []
for i in range(9):
    d.append(int(input()))

for c in list(combinations(d, 7)):
    if sum(c) == 100:
        answer = sorted(list(c))
        for h in answer:
            print(h)
        break
