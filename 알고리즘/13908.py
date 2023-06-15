import sys
from itertools import permutations, combinations_with_replacement

input = sys.stdin.readline
nums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
n, m = map(int, input().split())
shouldIn = set(map(int, input().split()))
intersect = set(nums).intersection(shouldIn)
answer = 0
shoudFind = n - m
combis = []
for ele in list(combinations_with_replacement(nums, shoudFind)):
    temp = list(shouldIn)
    for e in ele:
        temp.append(e)
    combis.append(temp)

for combi in combis:
    answer += len(set(permutations(combi, n)))

print(answer)
