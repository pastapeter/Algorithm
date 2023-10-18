import sys
from collections import deque
import math

input = sys.stdin.readline

# S: 시작점, N은 갯수

n, s = map(int, input().split())
a_list = list(map(int, input().split()))
c = []
for a in a_list:
    c.append(abs(a - s))
answers = []
print(math.gcd(*c))
